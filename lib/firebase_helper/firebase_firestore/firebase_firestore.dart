// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:h_firebase_demo/constants/contants.dart';
import 'package:h_firebase_demo/models/category_model/category_model.dart';
import 'package:h_firebase_demo/models/order_model/order_model.dart';
import 'package:h_firebase_demo/models/products_model/products_model.dart';
import 'package:h_firebase_demo/models/user_model/user_model.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<List<CategoryModel>> getCategories() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collection('categories').get();

      List<CategoryModel> catagoriesList = querySnapshot.docs
          .map((element) => CategoryModel.fromJson(element.data()))
          .toList();
      return catagoriesList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore.collectionGroup('products').get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((element) => ProductModel.fromJson(element.data()))
          .toList();
      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryViewProduct(String id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('categories')
              .doc(id)
              .collection('products')
              .get();

      List<ProductModel> productModelList = querySnapshot.docs
          .map((element) => ProductModel.fromJson(element.data()))
          .toList();
      return productModelList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<UserModel> getUserInformation() async {
    {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();

      return UserModel.fromJson(querySnapshot.data()!);
    }
  }

  Future<bool> uploadOrderedProductFirebase(
      List<ProductModel> list, BuildContext context, String payment) async {
    try {
      showLoaderDialog(context);
      double totalPrice = 0.0;
      for (var element in list) {
        totalPrice += element.price * element.qty!;
      }

      DocumentReference documentReference = _firebaseFirestore
          .collection('usersOrders')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orders')
          .doc();
      DocumentReference admin = _firebaseFirestore.collection('orders').doc();

      documentReference.set({
        'products': list.map((e) => e.toJson()),
        'status': 'pending',
        'totalPrice': totalPrice,
        'payment': payment,
        'orderId': documentReference.id,
      });

      admin.set({
        'products': list.map((e) => e.toJson()),
        'status': 'pending',
        'totalPrice': totalPrice,
        'payment': payment,
        'orderId': admin.id,
      });
      Navigator.of(context, rootNavigator: true).pop();
      showMessage('Ordered Successfully');
      return true;
    } catch (e) {
      showMessage(e.toString());
      Navigator.of(context, rootNavigator: true).pop();

      return false;
    }
  }

  /////////  Get Order User   ///////

  Future<List<OrderModel>> getUserOrder() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firebaseFirestore
              .collection('usersOrders')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('orders')
              .get();
      List<OrderModel> orderList = querySnapshot.docs
          .map((element) => OrderModel.fromJson(element.data()))
          .toList();

      return orderList;
    } catch (e) {
      showMessage(e.toString());
      return [];
    }
  }

  Future<void> updateTokenFromFirebase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'notificationToken': token,
      });
    }
  }
}
