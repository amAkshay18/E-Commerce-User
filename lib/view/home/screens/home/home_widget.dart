import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/view/home/indoor/indoor.dart';
import 'package:leafloom/view/home/outdoor/outdoor.dart';
import 'package:leafloom/view/home/screens/home/home_grid.dart';

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
      child: LayoutBuilder(builder: (context, constraints) {
        return ListView(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.black),
              height: 220,
              child: Image.asset(
                'assets/user_splash_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 10),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const OutdoorScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Adjust the border radius as needed
                            ),
                            elevation: 8,
                            shadowColor: Colors.grey,
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12), // Adjust padding as needed
                          ),
                          child: const Text(
                            'Outdoor',
                            style: TextStyle(
                              fontSize: 16, // Adjust the font size as needed
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const IndoorScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8,
                          shadowColor: Colors.grey,
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: const Text(
                          'Indoor',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 9.0,
                      left: 14,
                    ),
                    child: Text(
                      'All',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            HomeScreenGrid(productCollection: productCollection),
          ],
        );
      }),
    );
  }
}
