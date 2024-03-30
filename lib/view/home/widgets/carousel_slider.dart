import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/home/indoor/indoor.dart';
import 'package:leafloom/view/home/outdoor/outdoor.dart';

class CarouselSliderForCategories extends StatelessWidget {
  CarouselSliderForCategories({super.key});

  final List<String> categoryTitles = ['Indoor', 'Outdoor'];
  final List<String> categoryImages = [
    'assets/IndoorPlants.jpg',
    'assets/OutdoorPlants.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: [0, 1].map((index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => index == 0
                        ? const IndoorScreen()
                        : const OutdoorScreen(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(categoryImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: CustomText(
                        categoryTitles[index],
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
          ),
        ),
      ],
    );
  }
}
