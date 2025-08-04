import '../models/quiz.dart';
import '../models/question.dart';

class QuizData {
  static List<Quiz> getQuizzes() {
    return [
      Quiz(
        id: '1',
        title: 'Solar System Quiz',
        questions: [
          Question(
            question: 'Which planet in the Solar System is the smallest?',
            options: ['Pluto', 'Earth', 'Mercury', 'Mars'],
            correctAnswerIndex: 2,
          ),
          Question(
            question: 'Which planet is known as the Red Planet?',
            options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
            correctAnswerIndex: 1,
          ),
          Question(
            question: 'How many moons does Earth have?',
            options: ['0', '1', '2', '3'],
            correctAnswerIndex: 1,
          ),
          Question(
            question: 'Which is the largest planet in our solar system?',
            options: ['Saturn', 'Jupiter', 'Neptune', 'Uranus'],
            correctAnswerIndex: 1,
          ),
          Question(
            question: 'What is the hottest planet in our solar system?',
            options: ['Mercury', 'Venus', 'Mars', 'Earth'],
            correctAnswerIndex: 1,
          ),
        ],
      ),
      Quiz(
        id: '2',
        title: 'General Knowledge',
        questions: [
          Question(
            question: 'What is the capital of France?',
            options: ['London', 'Berlin', 'Paris', 'Madrid'],
            correctAnswerIndex: 2,
          ),
          Question(
            question: 'Which ocean is the largest?',
            options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
            correctAnswerIndex: 3,
          ),
          Question(
            question: 'How many continents are there?',
            options: ['5', '6', '7', '8'],
            correctAnswerIndex: 2,
          ),
        ],
      ),
      Quiz(
        id: '3',
        title: 'Science Quiz',
        questions: [
          Question(
            question: 'What is the chemical symbol for gold?',
            options: ['Go', 'Gd', 'Au', 'Ag'],
            correctAnswerIndex: 2,
          ),
          Question(
            question: 'How many bones are in an adult human body?',
            options: ['196', '206', '216', '226'],
            correctAnswerIndex: 1,
          ),
          Question(
            question: 'What gas do plants absorb from the atmosphere?',
            options: ['Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen'],
            correctAnswerIndex: 2,
          ),
        ],
      ),
    ];
  }
}
