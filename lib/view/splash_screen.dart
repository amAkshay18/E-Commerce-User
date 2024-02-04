import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/shared/bottomnavigation/bottom_bar.dart';
import 'package:leafloom/view/authentication_screens/log_in/screen/log_in.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(
        const Duration(seconds: 2),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData) {
                return const ScreenNavWidget();
              }
              return const ScreenLogin();
            },
          );
        } else {
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: Image.asset(
                  'assets/2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
