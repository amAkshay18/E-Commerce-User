import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/view/home/screens/home/home_widget.dart';
import 'package:leafloom/view/wishlist/wishlist.dart';
import 'package:leafloom/view_model/fetch_product.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');
  ValueNotifier<bool> notifier = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    fetchProducts();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.green,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Wishlist',
              ),
            ],
          ),
          title: const Text('Welcome'),
        ),
        body: TabBarView(
          children: [
            HomeScreenWidget(productCollection: productCollection),
            WishlistScreen()
            // Icon(Icons.directions_transit, size: 350),
          ],
        ),
      ),
    );
  }
}
