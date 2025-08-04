import 'package:flutter/material.dart';

class AppConstants {
  static const String developerName = 'Mohit Bawankar';

  // Colors
  static const Color primaryColor = Color(0xFF9C7AFF);
  static const Color gradientStart = Color(0xFFE1B3FF);
  static const Color gradientEnd = Color(0xFFC89DFF);

  // Text Styles
  static const TextStyle developerNameStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    letterSpacing: 1,
  );

  static const TextStyle quizTitleStyle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 8,
  );
}
