// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:leafloom/provider/bottomnavbar/bottom_nav_bar_provider.dart';
import 'package:leafloom/view/cart/screen/cart_screen.dart';
import 'package:leafloom/view/home/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/view/search/screen/search_screen.dart';
import 'package:leafloom/view/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

class ScreenNavWidget extends StatelessWidget {
  const ScreenNavWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final NavBarBottom provider = Provider.of<NavBarBottom>(context);
    // final themeData = Provider.of<ThemeProvider>(context).themeData;

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
                _buildTab(
                    Icons.favorite, 'Wishlist', 2, provider.selectedIndex),
                _buildTab(Icons.shopping_cart_outlined, 'Cart', 3,
                    provider.selectedIndex)
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
    bool isSelected = selectedIndex == tabIndex;
    return GButton(
      icon: icon,
      text: text,
      textColor:
          selectedIndex == tabIndex ? Colors.black : Colors.grey.shade600,
      textStyle: GoogleFonts.openSans(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return const SearchScreen();
      case 2:
        return const WishlistScreen();
      case 3:
        return const CartScreen();
      default:
        return HomeScreen();
    }
  }
}
