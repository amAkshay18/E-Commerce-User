// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class CommonButton extends StatelessWidget {
//   CommonButton({super.key, required this.name, required this.voidCallback});
//   final String name;
//   VoidCallback voidCallback;
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         voidCallback();
//       },
//       style: ButtonStyle(
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//         ),
//         backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
//         minimumSize: MaterialStateProperty.all<Size>(const Size(350, 60)),
//       ),
//       child: Text(
//         name,
//         style: const TextStyle(fontSize: 20, color: Colors.white),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonButton extends StatelessWidget {
  CommonButton({super.key, required this.name, required this.voidCallback});
  final String name;
  VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            voidCallback();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.amber,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            name,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
