// ignore_for_file: use_build_context_synchronously, empty_catches

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:h_firebase_demo/constants/routes.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:h_firebase_demo/provider/app_provider.dart';
import 'package:h_firebase_demo/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StripeHelper {
  static StripeHelper instance = StripeHelper();
  Future<void> makePayment(String amount, BuildContext context) async {
    Map<String, dynamic>? paymentIntent;
    try {
      /// Step-1  Create Payment Intent //////
      paymentIntent = await createPaymentIntent(amount, 'USD');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: 'US', currencyCode: 'USD', testEnv: true);

      /// Step-2 Initialize Payment Sheet ////
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.light,
              merchantDisplayName: 'Hardik',
              googlePay: gpay,
            ),
          )
          .then((value) {});

      ///// step-3  Display Payment Sheet  //////
      displayPaymentSheet(context);
    } catch (err) {}
  }

  displayPaymentSheet(BuildContext context) async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        bool value = await FirebaseFirestoreHelper.instance
            .uploadOrderedProductFirebase(
                appProvider.getBuyProductList, context, 'Paid');

        appProvider.clearBuyProduct();
        if (value) {
          Future.delayed(
            const Duration(seconds: 2),
            () {
              Routes.instance
                  .push(widget: const CustomBottomBar(), context: context);
            },
          );
        }
      });
    } catch (err) {
      print(err.toString());
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      /// Request Body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1PqupXDITMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPIq00wmjWwZYA',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
