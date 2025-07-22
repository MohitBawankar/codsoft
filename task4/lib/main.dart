import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(FlashCardApp());

class FlashCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlashCard Mastery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: Color(0xFFF0F3F8),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> categories = ['Biology', 'Chemistry', 'Physics'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FlashCard Mastery')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 6,
              child: ListTile(
                contentPadding: EdgeInsets.all(20),
                title: Text(categories[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                trailing: Icon(Icons.play_arrow_rounded),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FlashCardScreen(title: categories[index]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FlashCard {
  final String question;
  final String answer;

  FlashCard(this.question, this.answer);
}

class FlashCardScreen extends StatefulWidget {
  final String title;
  FlashCardScreen({required this.title});

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen> with SingleTickerProviderStateMixin {
  final List<FlashCard> cards = [
    FlashCard('What is the powerhouse of the cell?', 'Mitochondria'),
    FlashCard('What is H2O?', 'Water'),
    FlashCard('Speed of light in vacuum?', '299,792,458 m/s')
  ];

  int currentIndex = 0;
  bool showAnswer = false;

  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % cards.length;
      showAnswer = false;
    });
  }

  void flipCard() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = cards[currentIndex];
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: flipCard,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: MediaQuery.of(context).size.width * 0.85,
              height: 250,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    color: Colors.black26,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  showAnswer ? card.answer : card.question,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: nextCard,
            icon: Icon(Icons.navigate_next),
            label: Text("Next Card"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          )
        ],
      ),
    );
  }
}