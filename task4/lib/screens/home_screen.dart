import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import '../utils/constants.dart';
import 'quiz_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonWidgets.backgroundContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Developer Name
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text(
                  AppConstants.developerName,
                  style: AppConstants.developerNameStyle,
                ),
              ),

              // Quiz Icon and Title
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.quiz,
                      size: 80,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'QUIZ',
                      style: AppConstants.quizTitleStyle,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.white.withOpacity(0.6)),
                        SizedBox(width: 10),
                        Icon(Icons.psychology,
                            color: Colors.white.withOpacity(0.6)),
                        SizedBox(width: 10),
                        Icon(Icons.star, color: Colors.white.withOpacity(0.6)),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 60),

              // Start Button
              Container(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizSelectionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'START',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
