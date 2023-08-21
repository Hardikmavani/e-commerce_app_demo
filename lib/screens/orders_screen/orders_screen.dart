import 'package:flutter/material.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:h_firebase_demo/models/order_model/order_model.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Your Orders',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder(
        stream:
            Stream.fromFuture(FirebaseFirestoreHelper.instance.getUserOrder()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return const Center(
              child: Text('No Order Found'),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.red,
                        width: 2.5,
                      ),
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          color: Colors.red.withOpacity(0.5),
                          child: Image.network(orderModel.products[0].image),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderModel.products[0].name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                orderModel.products.length > 1
                                    ? SizedBox.fromSize()
                                    : Column(
                                        children: [
                                          Text(
                                            'Quantity: ${orderModel.products[0].qty.toString()}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      ),
                                Text(
                                  'Total Price: \$${orderModel.totalPrice.toString()}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Order Status: ${orderModel.status}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? [
                            const Text('Details'),
                            const Divider(
                              color: Colors.red,
                            ),
                            ...orderModel.products.map((singleProduct) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 6),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          color: Colors.red.withOpacity(0.5),
                                          child: Image.network(
                                            singleProduct.image,
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  singleProduct.name,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Quantity: ${singleProduct.qty.toString()}',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Price: \$${singleProduct.price.toString()}',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
