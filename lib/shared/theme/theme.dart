import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade400,
    primary: Colors.black,
    secondary: Colors.grey.shade200,
  ),
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.white,
    secondary: Colors.grey.shade700,
  ),
);

// import 'package:flutter/material.dart';

// // Light Mode Colors
// Color lightBackgroundColor = Colors.green.shade500; // Light green background
// Color lightTextColor = Colors.black; // Dark text for contrast
// Color lightButtonColor = Colors.brown; // Brown buttons
// Color lightAccentColor = Colors.green.shade700; // Vibrant green accents

// // Dark Mode Colors
// Color darkBackgroundColor = Colors.black87; // Dark background
// Color darkTextColor = Colors.white; // Light text for contrast
// Color darkButtonColor = Colors.green.shade200; // Lighter green buttons
// Color darkAccentColor = Colors.yellow; // Bright yellow accents

// ThemeData lightMode = ThemeData(
//   brightness: Brightness.light,
//   colorScheme: ColorScheme.light(
//     background: lightBackgroundColor, // Light green background
//     primary: lightTextColor, // Dark text for contrast
//     secondary: lightButtonColor, // Brown buttons
//     // You can customize more colors here if needed
//   ),
// );

// ThemeData darkMode = ThemeData(
//   brightness: Brightness.dark,
//   colorScheme: ColorScheme.dark(
//     background: darkBackgroundColor, // Dark background
//     primary: darkTextColor, // Light text for contrast
//     secondary: darkButtonColor, // Lighter green buttons
//     // You can customize more colors here if needed
//   ),
// );
