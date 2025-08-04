import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../data/quiz_data.dart';
import '../widgets/common_widgets.dart';
import '../utils/constants.dart';
import 'quiz_screen.dart';

class QuizSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizzes = QuizData.getQuizzes();

    return Scaffold(
      appBar: CommonWidgets.customAppBar('Select Quiz'),
      body: CommonWidgets.backgroundContainer(
        child: SafeArea(
          child: Column(
            children: [
              CommonWidgets.developerName(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Choose a Quiz',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: quizzes.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildRandomQuizCard(context, quizzes);
                    }

                    final quiz = quizzes[index - 1];
                    return _buildQuizCard(context, quiz);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRandomQuizCard(BuildContext context, List<Quiz> quizzes) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(
            Icons.shuffle,
            color: AppConstants.primaryColor,
            size: 30,
          ),
          title: Text(
            'Random Quiz',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('Mixed questions from all categories'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            final randomQuiz = _createRandomQuiz(quizzes);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(quiz: randomQuiz),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuizCard(BuildContext context, Quiz quiz) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Icon(
            Icons.quiz,
            color: AppConstants.primaryColor,
            size: 30,
          ),
          title: Text(
            quiz.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('${quiz.questions.length} questions'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(quiz: quiz),
              ),
            );
          },
        ),
      ),
    );
  }

  Quiz _createRandomQuiz(List<Quiz> quizzes) {
    List<Question> allQuestions = [];
    for (var quiz in quizzes) {
      allQuestions.addAll(quiz.questions);
    }
    allQuestions.shuffle();

    return Quiz(
      id: 'random',
      title: 'Random Quiz',
      questions: allQuestions.take(5).toList(),
    );
  }
}
