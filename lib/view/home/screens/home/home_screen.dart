import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:leafloom/provider/theme/theme_provider.dart';
import 'package:leafloom/shared/common_widget/common_button.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/address/screens/main_address_screen.dart';
import 'package:leafloom/view/authentication/screens/login_screen.dart';
import 'package:leafloom/view/home/screens/home/home_grid.dart';
import 'package:leafloom/view/home/widgets/carousel_slider.dart';
import 'package:leafloom/view/orders/orders_screen.dart';
import 'package:leafloom/view/settings/settings_screen.dart';
import 'package:leafloom/view_model/fetch_product.dart';
// import 'package:provider/provider.dart';

ValueNotifier<Map<String, dynamic>> userDetailsNotifier =
    ValueNotifier({'name': '', 'email': ''});

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');
  ValueNotifier<bool> notifier = ValueNotifier(true);

  fetchProfileDetails() async {
    final user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get();
    userDetailsNotifier.value = {
      'name': user.data()!['name'],
      'email': user.data()!['email']
    };
  }

  @override
  Widget build(BuildContext context) {
    fetchProducts();
    fetchProfileDetails();
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
                      color: Colors.grey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: userDetailsNotifier,
                          builder: (context, value, _) {
                            return Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: CustomTextWidget(
                                    (value['name'] as String)
                                        .substring(0, 1)
                                        .toUpperCase(),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Builder(
                                  builder: (context) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextWidget(
                                          value['name'],
                                          fontSize: 18,
                                        ),
                                        CustomTextWidget(
                                          value['email'],
                                          fontSize: 14,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     Provider.of<ThemeProvider>(context, listen: false)
                        //         .toggleTheme();
                        //   },
                        //   icon: const Icon(
                        //     Icons.dark_mode,
                        //     color: Colors.white,
                        //   ),
                        // ),
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
              name: 'Log out',
              voidCallback: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: const CustomTextWidget(
                      'Log out',
                      fontSize: 16,
                    ),
                    content: const CustomTextWidget(
                      "Are you sure you want to logout?",
                      fontSize: 16,
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const CustomTextWidget(
                              "Cancel",
                              fontSize: 16,
                            ),
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
                            child: const CustomTextWidget(
                              "Log out",
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const CustomTextWidget(
          'LeafLoom',
          fontSize: 26,
          // color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: HomeScreenWidget(productCollection: productCollection),
    );
  }
}

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({
    super.key,
    required this.productCollection,
  });

  final CollectionReference<Object?> productCollection;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white30),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8.0, left: 10, bottom: 8),
            child: CustomTextWidget(
              'Categories',
            ),
          ),
          CarouselSliderForCategories(),
          const Padding(
            padding: EdgeInsets.only(
              top: 9.0,
              left: 14,
            ),
            child: CustomTextWidget(
              'All Products',
            ),
          ),
          HomeScreenGrid(productCollection: productCollection),
        ],
      ),
    );
  }
}
