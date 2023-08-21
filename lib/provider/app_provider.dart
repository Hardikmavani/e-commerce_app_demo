// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/contants.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_firestore/firebase_firestore.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_storage_helper/firebase_store_helper.dart';
import 'package:h_firebase_demo/models/products_model/products_model.dart';
import 'package:h_firebase_demo/models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  // Cart work
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];

  UserModel? _userModel;

  UserModel get getUserInformation => _userModel!;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  ////// Favourite  ///////
  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  //////// User Information
  Future<void> getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  Future<void> updateUserInfoFirebase(
      BuildContext context, userModel, File? file) async {
    if (file == null) {
      showLoaderDialog(context);

      _userModel = userModel;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userModel!.id)
          .set(_userModel!.toJson());

      Navigator.of(context, rootNavigator: true);
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);

      String imageUrl =
          await FirebaseStoregeHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      Navigator.of(context, rootNavigator: true);
      Navigator.of(context).pop();
    }
    showMessage('Successfully updated profile');

    notifyListeners();
  }

  ////////// TOTAL PRICE //////////
  double totalPrice() {
    double totalPrice = 0.0;
    for (var element in _cartProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  double totalPriceBuyProductList() {
    double totalPrice = 0.0;
    for (var element in _buyProductList) {
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }

  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }

  ///////  BUY Product  ///////

  void addBuyProduct(ProductModel model) {
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList() {
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }

  void clearCart() {
    _cartProductList.clear();
    notifyListeners();
  }

  void clearBuyProduct() {
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;
}
