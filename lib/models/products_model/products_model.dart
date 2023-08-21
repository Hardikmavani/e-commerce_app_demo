// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {required this.image,
      required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.isFavaourite,
      this.qty});

  String image;
  String id;
  String name;
  double price;
  String description;
  bool isFavaourite;
  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      qty: json['qty'],
      image: json['image'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      isFavaourite: false);

  Map<String, dynamic> toJson() => {
        'image': image,
        'id': id,
        'name': name,
        'price': price,
        'qty': qty,
        'description': description,
        'isFavourite': isFavaourite
      };

  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
          id: id,
          name: name,
          qty: qty ?? this.qty,
          image: image,
          price: price,
          description: description,
          isFavaourite: false);
}
