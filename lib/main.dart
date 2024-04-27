import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/firebase_options.dart';
import 'package:leafloom/provider/address/address_provider.dart';
import 'package:leafloom/provider/bottomnavbar/bottom_nav_bar_provider.dart';
import 'package:leafloom/provider/cart/cart_provider.dart';
import 'package:leafloom/provider/checkout_provider/checkout_provider.dart';
import 'package:leafloom/provider/indoor_outdoor/indoor_outdoor_provider.dart';
import 'package:leafloom/provider/search/search_provider.dart';
import 'package:leafloom/provider/wishlist/wishlist_provider.dart';
import 'package:leafloom/shared/theme/theme.dart';
import 'package:leafloom/view/splash/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavBarBottom(),
        ),
        ChangeNotifierProvider(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomSheetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AlertDialogProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RazorpayProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductPayment(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => ThemeProvider(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
