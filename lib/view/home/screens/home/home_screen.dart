import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/account/screens/account_screen.dart';
import 'package:leafloom/view/home/screens/home/home_widget.dart';
import 'package:leafloom/view_model/fetch_product.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');
  ValueNotifier<bool> notifier = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    fetchProducts();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
        title: const CustomTextWidget(
          'LeafLoom',
          fontSize: 26,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: HomeScreenWidget(productCollection: productCollection),
    );
  }
}
