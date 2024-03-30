// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

double screenHeight = 0.0;
double screenWidth = 0.0;

void initializeScreenSize(BuildContext context) {
  screenHeight = MediaQuery.of(context).size.height;
  screenWidth = MediaQuery.of(context).size.width;
}

//Custom heights
final kHeight1 = SizedBox(
  height: screenHeight * 0.01,
);
final kHeight2 = SizedBox(
  height: screenHeight * 0.02,
);
final kHeight3 = SizedBox(
  height: screenHeight * 0.03,
);

final kHeight4 = SizedBox(
  height: screenHeight * 0.04,
);

//Custom widths
final kWidth1 = SizedBox(
  width: screenWidth * 0.01,
);

final kWidth2 = SizedBox(
  width: screenWidth * 0.02,
);
final kWidth3 = SizedBox(
  width: screenWidth * 0.03,
);

// ------------------------------------------------------------------------------------------------------------

//==================================     Heading Fontsize   ========================================
const TextStyle kTitle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

//======================================    Colors    ================================================
const LinearGradient gcolor = LinearGradient(colors: [
  Color.fromARGB(255, 36, 211, 124),
  Color.fromARGB(255, 112, 161, 137),
], begin: Alignment.topLeft);

//======================================    Height   ===================================================
const kHeight50 = SizedBox(
  height: 50,
);
const kHeight40 = SizedBox(
  height: 40,
);
const kHeight30 = SizedBox(
  height: 30,
);
const kHeight20 = SizedBox(
  height: 20,
);
const kHeight10 = SizedBox(
  height: 10,
);

//=======================================  TextField  ===================================================
class CommonTextFields extends StatelessWidget {
  const CommonTextFields({
    super.key,
    required TextEditingController nameControllor,
    required this.labelText,
    required this.validator,
    required this.inputType,
  }) : _nameControllor = nameControllor;

  final TextEditingController _nameControllor;
  final String labelText;
  final String validator;
  final TextInputType inputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      controller: _nameControllor,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validator;
        }
        return null;
      },
    );
  }
}

// ======================================  CommonButton 2  =======================================
class CommonButtonTwo extends StatelessWidget {
  CommonButtonTwo(
      {super.key,
      required this.name,
      required this.voidCallback,
      this.change,
      this.id});
  final String name;
  final String? change;
  final String? id;
  VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        voidCallback();
        Navigator.of(context).pop();
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(350, 60),
        ),
      ),
      child: Text(
        name,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
