import 'dart:math';
import '../models/quote.dart';

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
    final today = DateTime.now();
    final seed = today.year * 1000 + today.month * 100 + today.day;
    final random = Random(seed);
    return _quotes[random.nextInt(_quotes.length)];
  }

  static List<Quote> getAllQuotes() {
    return List.from(_quotes);
  }
}