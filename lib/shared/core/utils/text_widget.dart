import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final String fontFamily;
  final Color color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const CustomText(this.text,
      {super.key,
      this.fontFamily = 'Poppins',
      this.color = Colors.black,
      this.fontWeight,
      this.fontSize = 20,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont(fontFamily,
          color: color, fontWeight: fontWeight, fontSize: fontSize),
      textAlign: textAlign,
    );
  }
}
