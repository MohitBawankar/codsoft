import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task1/screens/splash_screen.dart'; // Import the new splash screen

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark, // Ensures status bar icons are visible
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity, // Adjusts UI for different screen sizes
      ),
      home: const SplashScreen(), // Set SplashScreen as the initial screen
      debugShowCheckedModeBanner: false,
    );
  }
}