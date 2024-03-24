// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/model/cart_model.dart';

class CartServices {
  final _firebase = FirebaseFirestore.instance;
  Future<void> addToCart(CartModel cartModel, BuildContext context) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.email;
      await _firebase
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(cartModel.id)
          .set(cartModel.toJson());
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  removeFromCart(String id, BuildContext context) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.email;
      await _firebase
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(id)
          .delete();
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<Either<String, List<CartModel>>> getCartItems() async {
    final userId = FirebaseAuth.instance.currentUser!.email;
    final items = await _firebase
        .collection('users')
        .doc(userId)
        .collection('cart')
        .get();
    if (items.docs.isEmpty) {
      return right([]);
    } else {
      final cartItems =
          items.docs.map((e) => CartModel.fromJson(e.data())).toList();
      return right(cartItems);
    }
  }

  Future<void> updateQuantity(
      CartModel cartModel, bool isAdd, BuildContext context) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.email;
      int quantity = int.parse(cartModel.quantity!);
      final newQuantity = isAdd ? (quantity += 1) : (quantity -= 1);
      if (newQuantity >= 0) {
        await _firebase
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(cartModel.id)
            .update({'quantity': newQuantity.toString()});
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  clearCart(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser!.email;
    try {
      final document = await _firebase
          .collection('users')
          .doc(user)
          .collection('cart')
          .get();
      for (DocumentSnapshot element in document.docs) {
        await element.reference.delete();
      }
      showSnackbar(context, 'Your order has placed successfully');
    } catch (e) {
      showSnackbar(context, 'Failed to clear cart. Please try again.');
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 10.0),
      content: Text(message),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
