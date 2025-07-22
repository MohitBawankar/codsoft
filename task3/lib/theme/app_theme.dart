import 'package:flutter/material.dart';

class AppTheme {
  // Color constants
  static const Color primaryBlue = Color(0xFF4A90E2);
  static const Color darkBackground = Color(0xFF0A0E27);
  static const Color cardBackground = Color(0xFF1A1D3A);
  static const Color secondaryCardBackground = Color(0xFF2A2D4A);

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: cardBackground,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return primaryBlue;
            }
            return Colors.grey;
          },
        ),
        trackColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return primaryBlue.withOpacity(0.5);
            }
            return Colors.grey.withOpacity(0.3);
          },
        ),
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: cardBackground,
        hourMinuteColor: primaryBlue,
        dayPeriodColor: primaryBlue,
      ),
    );
  }

  static BoxDecoration get gradientBackground {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [darkBackground, cardBackground],
      ),
    );
  }

  static BoxDecoration cardDecoration({bool isEnabled = true, bool hasBorder = false}) {
    return BoxDecoration(
      color: isEnabled ? secondaryCardBackground : cardBackground,
      borderRadius: BorderRadius.circular(15),
      border: hasBorder && isEnabled ? Border.all(color: primaryBlue, width: 1) : null,
    );
  }
}