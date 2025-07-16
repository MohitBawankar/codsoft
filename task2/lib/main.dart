import 'package:flutter/material.dart';
import 'package:task2/screens/home_screen.dart'; // Import the home screen

void main() {
  // Run the Flutter application
  runApp(const MyApp());
}

// Define the root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspiring Quotes', // Title of the application
      theme: ThemeData(
        // Define the primary color scheme for the app
        primarySwatch: Colors.deepPurple,
        // Set the default font family for the app
        fontFamily: 'Inter',
        // Define the visual density for all widgets
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Configure the app bar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple, // App bar background color
          foregroundColor: Colors.white, // App bar text and icon color
          elevation: 4, // Shadow below the app bar
          centerTitle: true, // Center the title on the app bar
        ),
        // Configure the card theme for a consistent look
        cardTheme: CardTheme(
          elevation: 6, // Shadow for cards
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15), // Rounded corners for cards
          ),
          margin: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 8), // Margin around cards
        ),
        // Configure the elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent, // Button background color
            foregroundColor: Colors.white, // Button text color
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Rounded corners for buttons
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 12), // Padding inside buttons
          ),
        ),
        // Configure the text theme for various text styles
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Colors.black87,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        // Configure the floating action button theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurpleAccent, // FAB background color
          foregroundColor: Colors.white, // FAB icon color
        ),
      ),
      home: const HomeScreen(), // Set the HomeScreen as the initial screen
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math';

void main() {
  runApp(const DailyQuoteApp());
}

class DailyQuoteApp extends StatelessWidget {
  const DailyQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Inspiration',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'author': author,
    };
  }

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['text'],
      author: json['author'],
    );
  }
}

class QuoteService {
  static final List<Quote> _quotes = [
    Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
    Quote(text: "Innovation distinguishes between a leader and a follower.", author: "Steve Jobs"),
    Quote(text: "Life is what happens to you while you're busy making other plans.", author: "John Lennon"),
    Quote(text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt"),
    Quote(text: "It is during our darkest moments that we must focus to see the light.", author: "Aristotle"),
    Quote(text: "The only impossible journey is the one you never begin.", author: "Tony Robbins"),
    Quote(text: "In the middle of difficulty lies opportunity.", author: "Albert Einstein"),
    Quote(text: "Success is not final, failure is not fatal: it is the courage to continue that counts.", author: "Winston Churchill"),
    Quote(text: "The way to get started is to quit talking and begin doing.", author: "Walt Disney"),
    Quote(text: "Don't let yesterday take up too much of today.", author: "Will Rogers"),
    Quote(text: "You learn more from failure than from success.", author: "Unknown"),
    Quote(text: "If you are working on something that you really care about, you don't have to be pushed.", author: "Steve Jobs"),
    Quote(text: "Experience is the teacher of all things.", author: "Julius Caesar"),
    Quote(text: "The only person you are destined to become is the person you decide to be.", author: "Ralph Waldo Emerson"),
    Quote(text: "Go confidently in the direction of your dreams. Live the life you have imagined.", author: "Henry David Thoreau"),
    Quote(text: "Everything you've ever wanted is on the other side of fear.", author: "George Addair"),
    Quote(text: "Believe you can and you're halfway there.", author: "Theodore Roosevelt"),
    Quote(text: "The only limit to our realization of tomorrow will be our doubts of today.", author: "Franklin D. Roosevelt"),
    Quote(text: "Do something wonderful, people may imitate it.", author: "Albert Schweitzer"),
    Quote(text: "The best time to plant a tree was 20 years ago. The second best time is now.", author: "Chinese Proverb"),
  ];

  static Quote getRandomQuote() {
    final random = Random();
    return _quotes[random.nextInt(_quotes.length)];
  }

  static Quote getDailyQuote() {
    // Use date as seed for consistent daily quote
    final today = DateTime.now();
    final seed = today.year * 1000 + today.month * 100 + today.day;
    final random = Random(seed);
    return _quotes[random.nextInt(_quotes.length)];
  }

  static List<Quote> getAllQuotes() {
    return List.from(_quotes);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Quote currentQuote = QuoteService.getDailyQuote();
  List<Quote> favoriteQuotes = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadDailyQuote();
  }

  void _loadDailyQuote() {
    setState(() {
      currentQuote = QuoteService.getDailyQuote();
    });
  }

  void _refreshQuote() {
    setState(() {
      currentQuote = QuoteService.getRandomQuote();
    });
  }

  void _shareQuote() {
    Share.share('"${currentQuote.text}" - ${currentQuote.author}');
  }

  void _toggleFavorite() {
    setState(() {
      final isAlreadyFavorite = favoriteQuotes.any((q) =>
      q.text == currentQuote.text && q.author == currentQuote.author);

      if (isAlreadyFavorite) {
        favoriteQuotes.removeWhere((q) =>
        q.text == currentQuote.text && q.author == currentQuote.author);
      } else {
        favoriteQuotes.add(currentQuote);
      }
    });
  }

  bool _isFavorite() {
    return favoriteQuotes.any((q) =>
    q.text == currentQuote.text && q.author == currentQuote.author);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          _buildHomeTab(),
          _buildFavoritesTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6B73FF),
            Color(0xFF9B59B6),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daily Inspiration',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white, size: 28),
                    onPressed: _refreshQuote,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Date
              Text(
                _formatDate(DateTime.now()),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 40),

              // Quote Card
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Quote icon
                        Icon(
                          Icons.format_quote,
                          size: 48,
                          color: Colors.purple.shade300,
                        ),

                        const SizedBox(height: 30),

                        // Quote text
                        Text(
                          currentQuote.text,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2C3E50),
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 30),

                        // Author
                        Text(
                          '— ${currentQuote.author}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _shareQuote,
                      icon: const Icon(Icons.share, color: Colors.white),
                      label: const Text('Share'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  ElevatedButton(
                    onPressed: _toggleFavorite,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Icon(
                      _isFavorite() ? Icons.favorite : Icons.favorite_border,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF6B73FF),
            Color(0xFF9B59B6),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  const Text(
                    'Favorite Quotes',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${favoriteQuotes.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Favorites list
            Expanded(
              child: favoriteQuotes.isEmpty
                  ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 64,
                      color: Colors.white70,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No favorites yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap the heart icon to add quotes to favorites',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white60,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: favoriteQuotes.length,
                itemBuilder: (context, index) {
                  final quote = favoriteQuotes[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(20),
                      title: Text(
                        quote.text,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '— ${quote.author}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.grey),
                            onPressed: () {
                              Share.share('"${quote.text}" - ${quote.author}');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                favoriteQuotes.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DailyQuoteApp());
}

class DailyQuoteApp extends StatelessWidget {
  const DailyQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Inspiration',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}