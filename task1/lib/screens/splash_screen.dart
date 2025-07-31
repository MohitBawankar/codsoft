import 'package:flutter/material.dart';
import 'package:task1/screens/todo_home_page.dart'; // Import the home page

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Image source: https://unsplash.com/photos/a-person-writing-on-a-notebook-with-a-pen-on-a-wooden-desk-Q-t4j-g5z4U
  final String splashImageUrl = 'https://images.unsplash.com/photo-1507679799977-c9371235f992?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {}); // Simulate a loading time
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TodoHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C63FF), // A pleasant background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Splash image
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0), // Rounded corners for the image
              child: Image.network(
                splashImageUrl,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: Icon(Icons.error, color: Colors.grey[600], size: 50),
                    alignment: Alignment.center,
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'My Daily Tasks',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Organize your life, one task at a time.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}