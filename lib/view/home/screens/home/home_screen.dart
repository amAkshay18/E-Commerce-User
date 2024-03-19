import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/view/account/screens/account.dart';
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
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    fetchProducts();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenAccount(),
                  ),
                );
              },
              icon: const Icon(Icons.person),
            ),
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const SampleScreen(),
            //         ),
            //       );
            //     },
            //     icon: const Icon(Icons.abc))
          ],
          automaticallyImplyLeading: false,
          // bottom: const TabBar(
          //   indicatorSize: TabBarIndicatorSize.label,
          //   indicatorColor: Colors.green,
          //   tabs: [
          //     Tab(
          //       icon: Icon(Icons.home),
          //       text: 'Home',
          //     ),
          //     Tab(
          //       icon: Icon(Icons.favorite),
          //       text: 'Wishlist',
          //     ),
          //   ],
          // ),
          title: const Text(
            'LeafLoom',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: HomeScreenWidget(productCollection: productCollection),

        //  TabBarView(
        //   children: [
        //     HomeScreenWidget(productCollection: productCollection),
        //     WishlistScreen(),
        //   ],
        // ),
      ),
    );
  }
}
