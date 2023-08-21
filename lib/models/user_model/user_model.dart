// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel(
      {this.image, required this.id, required this.name, required this.email});

  String? image;
  String email;
  String id;
  String name;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        image: json['image'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'email': email,
        'name': name,
        'id': id,
      };

  UserModel copyWith({
    String? name,
    image,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        email: email,
        image: image ?? this.image,
      );
}
