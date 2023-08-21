// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:h_firebase_demo/models/products_model/products_model.dart';

class OrderModel {
  OrderModel({
    required this.payment,
    required this.orderId,
    required this.status,
    required this.totalPrice,
    required this.products,
  });

  String payment;
  String orderId;
  String status;
  double totalPrice;
  List<ProductModel> products;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json['products'];
    return OrderModel(
      payment: json['payment'],
      status: json['status'],
      totalPrice: json['totalPrice'],
      orderId: json['orderId'],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
    );
  }
}
