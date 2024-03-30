import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/provider/account/about_us/about_us.dart';
import 'package:leafloom/provider/account/privacy_policy/privacy_policy.dart';
import 'package:leafloom/provider/account/terms_conditions/terms_conditions.dart';
import 'package:leafloom/shared/common_widget/common_button.dart';
import 'package:leafloom/shared/core/constants.dart';
import 'package:leafloom/view/account/address/screens/main_address_screen.dart';
import 'package:leafloom/view/account/orders/orders_screen.dart';
import 'package:leafloom/view/account/widgets/account_tile.dart';
import 'package:leafloom/view/authentication/screens/login_screen.dart';
import 'package:provider/provider.dart';

class AccountBody extends StatelessWidget {
  const AccountBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: gcolor,
        ),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  height: 340,
                  width: 350,
                  child: Column(
                    children: [
                      AccountTile(
                        icon: Icons.shopping_bag_rounded,
                        name: 'Orders',
                        voidCallback: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OrdersScreen(),
                            ),
                          );
                        },
                      ),
                      AccountTile(
                        icon: Icons.article,
                        name: 'Addresses',
                        voidCallback: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ScreenAddress(),
                            ),
                          );
                        },
                      ),
                      AccountTile(
                        icon: Icons.privacy_tip,
                        name: 'Privacy and Policy',
                        voidCallback: () {
                          context
                              .read<PrivacyPolicyProvider>()
                              .privacyPolicyMethod(context);
                        },
                      ),
                      AccountTile(
                        icon: Icons.file_copy,
                        name: 'Terms and Conditions',
                        voidCallback: () {
                          context
                              .read<TermsAndConditonsProvider>()
                              .termsAndConditionsMethod(context);
                        },
                      ),
                      AccountTile(
                        icon: CupertinoIcons.info_circle_fill,
                        name: 'About Us',
                        voidCallback: () {
                          context
                              .read<AboutUsProvider>()
                              .aboutUsMethod(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
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
                          child: const Text("Cancel")),
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
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 160),
          ],
        ),
      ),
    );
  }
}
