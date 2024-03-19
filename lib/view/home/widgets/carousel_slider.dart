// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:leafloom/shared/core/constants.dart';

// List<String> assetImages = [
//   // 'assets/images/sparx.jpg',
//   // 'assets/images/Red tape ad.jpg',
//   'assets/user_splash_image.jpg',
//   'assets/user_splash_image.jpg',
//   'assets/user_splash_image.jpg',
//   'assets/user_splash_image.jpg',
//   'assets/user_splash_image.jpg',
//   // 'assets/images/Bata ad.jpeg',
// ];

// class Advertisement extends StatelessWidget {
//   const Advertisement({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       items: assetImages.map(
//         (image) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 5),
//             child: Container(
//               height: screenHeight * 0.2,
//               width: screenWidth,
//               decoration: BoxDecoration(
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black,
//                     offset: Offset(0, 3),
//                     blurRadius: 4,
//                   ),
//                 ],
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(15),
//                 ),
//                 image: DecorationImage(
//                   image: AssetImage(image),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           );
//         },
//       ).toList(),
//       options: CarouselOptions(
//         height: screenHeight * 0.2,
//         aspectRatio: 16 / 9,
//         viewportFraction: 0.9,
//         initialPage: 0,
//         enableInfiniteScroll: true,
//         autoPlay: true,
//         autoPlayInterval: const Duration(seconds: 5),
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         autoPlayCurve: Curves.fastOutSlowIn,
//         scrollDirection: Axis.horizontal,
//       ),
//     );
//   }
// }
