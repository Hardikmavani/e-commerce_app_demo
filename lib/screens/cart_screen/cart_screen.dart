import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/contants.dart';
import 'package:h_firebase_demo/constants/routes.dart';
import 'package:h_firebase_demo/provider/app_provider.dart';
import 'package:h_firebase_demo/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:h_firebase_demo/screens/cart_screen/widgets/single_cart_item.dart';
import 'package:h_firebase_demo/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${appProvider.totalPrice().toString()}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              PrimaryButton(
                title: 'Checkout',
                onPressed: () {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductCartList();
                  appProvider.clearCart();
                  if (appProvider.getBuyProductList.isEmpty) {
                    showMessage('Cart is empty');
                  } else {
                    Routes.instance.push(
                        widget: const CartItemCheckout(), context: context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cart Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? const Center(child: Text('Empty'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: appProvider.getCartProductList.length,
              itemBuilder: (context, index) {
                return SingleCartIem(
                    singleProduct: appProvider.getCartProductList[index]);
              },
            ),
    );
  }
}
