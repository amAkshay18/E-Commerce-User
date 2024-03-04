// ignore: depend_on_referenced_packages
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
    final NavBarBottom provider = Provider.of<NavBarBottom>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _getPage(provider.selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.3),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 7,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              tabBackgroundColor: Colors.white,
              color: Colors.grey.shade600,
              tabs: [
                _buildTab(Icons.home, 'Home', 0, provider.selectedIndex),
                _buildTab(Icons.search, 'Search', 1, provider.selectedIndex),
                _buildTab(Icons.shopping_cart_outlined, 'Cart', 2,
                    provider.selectedIndex),
                _buildTab(Icons.person, 'Profile', 3, provider.selectedIndex),
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

  GButton _buildTab(
      IconData icon, String text, int tabIndex, int selectedIndex) {
    return GButton(
      icon: icon,
      text: text,
      textColor:
          selectedIndex == tabIndex ? Colors.black : Colors.grey.shade600,
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return const SearchScreen();
      case 2:
        return CartScreen();
      case 3:
        return const ScreenProfile();
      default:
        return HomeScreen();
    }
  }
}
