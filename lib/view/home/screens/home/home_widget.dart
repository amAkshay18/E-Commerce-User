import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/home/screens/home/home_grid.dart';
import 'package:leafloom/view/home/widgets/carousel_slider.dart';

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
