import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/shared/common_widget/common_button.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/address/screens/main_address_screen.dart';
import 'package:leafloom/view/authentication/screens/login_screen.dart';
import 'package:leafloom/view/home/screens/home/home_widget.dart';
import 'package:leafloom/view/orders/orders_screen.dart';
import 'package:leafloom/view/settings/screens/settings_screen.dart';
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
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                              child: CustomTextWidget('AK'),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  'Akshay P',
                                  fontSize: 18,
                                ),
                                CustomTextWidget(
                                  'akshay@example.com',
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.dark_mode,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const ListTile(
                  //   title: CustomTextWidget(
                  //     'Edit Profile',
                  //     fontSize: 18,
                  //   ),
                  // ),
                  ListTile(
                    title: const CustomTextWidget(
                      'Orders',
                      fontSize: 18,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const OrdersScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const CustomTextWidget(
                      'Addresses',
                      fontSize: 18,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ScreenAddress(),
                        ),
                      );
                    },
                  ),
                  // const ListTile(
                  //   title: CustomTextWidget(
                  //     'Share',
                  //     fontSize: 18,
                  //   ),
                  // ),
                  ListTile(
                    title: const CustomTextWidget(
                      'Settings',
                      fontSize: 18,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            CommonButton(
              name: 'Log Out',
              voidCallback: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text("Are you sure want to logout"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut().whenComplete(() {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false,
                            );
                          });
                        },
                        child: const CustomTextWidget("Logout"),
                      ),
                    ],
                  ),
                );
              },
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: const CustomTextWidget('Log out'),
            // ),
          ],
        ),
      ),
      appBar: AppBar(
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
