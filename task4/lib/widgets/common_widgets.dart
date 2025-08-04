import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CommonWidgets {
  static Widget backgroundContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppConstants.gradientStart,
            AppConstants.gradientEnd,
          ],
        ),
      ),
      child: child,
    );
  }

  static Widget developerName() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        AppConstants.developerName,
        style: AppConstants.developerNameStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  static AppBar customAppBar(String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: AppConstants.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    );
  }
}
