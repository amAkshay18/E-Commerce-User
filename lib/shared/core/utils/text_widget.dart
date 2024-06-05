import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final String fontFamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  // final Color? color;

  const CustomTextWidget(
    this.text, {
    Key? key,
    this.fontFamily = 'Open Sans',
    this.fontWeight,
    this.fontSize = 20,
    this.textAlign,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    // this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black
        : Colors.white;

    return Text(
      text,
      style: GoogleFonts.getFont(
        fontFamily,
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
