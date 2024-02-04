import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:leafloom/provider/bottomnavbar/bottom_nav_bar_provider.dart';
import 'package:leafloom/view/cart/screen/cart.dart';
import 'package:leafloom/view/home/screens/home/home_screen.dart';
import 'package:leafloom/view/profile/screens/profile.dart';
import 'package:leafloom/view/search/screen/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenNavWidget extends StatelessWidget {
  const ScreenNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavBarBottom>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: provider.selectedIndex == 0
            ? HomeScreen()
            : provider.selectedIndex == 1
                ? const SearchScreen()
                : provider.selectedIndex == 2
                    ? CartScreen()
                    : const ScreenProfile(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.3),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.amber[300]!,
              hoverColor: Colors.blue[300]!,
              gap: 7,
              activeColor: Colors.white,
              iconSize: 27,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.black,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.shopping_cart_outlined,
                  text: 'Cart',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: provider.selectedIndex,
              onTabChange: (index) {
                provider.selectedIndex = index;
              },
            ),
          ),
        ),
      ),
    );
  }
}
