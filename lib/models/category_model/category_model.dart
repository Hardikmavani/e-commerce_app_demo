// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel(
      {required this.image,
      required this.id,
      required this.isFavaourite,
      required this.name});

  String image;
  String id;
  String name;

  bool isFavaourite;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      name: json['name'],
      image: json['image'],
      id: json['id'],
      isFavaourite: false);

  Map<String, dynamic> toJson() =>
      {'image': image, 'name': name, 'id': id, 'isFavourite': isFavaourite};
}
