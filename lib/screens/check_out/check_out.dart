// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/routes.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:h_firebase_demo/models/products_model/products_model.dart';
import 'package:h_firebase_demo/provider/app_provider.dart';
import 'package:h_firebase_demo/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:h_firebase_demo/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  final ProductModel singleProduct;
  const Checkout({super.key, required this.singleProduct});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 36,
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  )),
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Cash on Delivery',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 3,
                  )),
              child: Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value!;
                      });
                    },
                  ),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Pay Online',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            PrimaryButton(
              title: 'Continue',
              onPressed: () async {
                appProvider.clearBuyProduct();
                appProvider.addBuyProduct(widget.singleProduct);

                bool value = await FirebaseFirestoreHelper.instance
                    .uploadOrderedProductFirebase(appProvider.getBuyProductList,
                        context, groupValue == 1 ? 'Cash on delivery' : 'Paid');
                if (value) {
                  Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      Routes.instance.push(
                          widget: const CustomBottomBar(), context: context);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
