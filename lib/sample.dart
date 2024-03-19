// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:leafloom/shared/core/constants.dart';
// import 'package:leafloom/view/home/widgets/carousel_slider.dart';

// class SampleScreen extends StatelessWidget {
//   const SampleScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sample'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: CarouselSlider(
//           items: assetImages.map(
//             (image) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 5),
//                 child: Container(
//                   height: screenHeight * 0.28,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.grey,
//                         offset: Offset(0, 3),
//                         blurRadius: 4,
//                       ),
//                     ],
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(15),
//                     ),
//                     image: DecorationImage(
//                       image: AssetImage(image),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ).toList(),
//           options: CarouselOptions(
//             height: screenHeight * 0.28,
//             aspectRatio: 16 / 9,
//             viewportFraction: 0.9,
//             initialPage: 0,
//             enableInfiniteScroll: true,
//             autoPlay: true,
//             autoPlayInterval: const Duration(seconds: 5),
//             autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             autoPlayCurve: Curves.fastOutSlowIn,
//             scrollDirection: Axis.horizontal,
//           ),
//         ),
//       ),
//     );
//   }
// }
