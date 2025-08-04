import 'package:flutter/material.dart';
import '../models/quiz.dart';
import '../widgets/common_widgets.dart';
import '../utils/constants.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;

  QuizScreen({required this.quiz});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;
  List<int> userAnswers = [];
  bool showFeedback = false;

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[currentQuestionIndex];

    return Scaffold(
      appBar: CommonWidgets.customAppBar(widget.quiz.title),
      body: CommonWidgets.backgroundContainer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CommonWidgets.developerName(),
                _buildQuestionProgress(),
                SizedBox(height: 20),
                _buildProgressBar(),
                SizedBox(height: 40),
                _buildQuestionCard(question),
                SizedBox(height: 30),
                _buildAnswerOptions(question),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Q${currentQuestionIndex + 1}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '${currentQuestionIndex + 1}/${widget.quiz.questions.length}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return LinearProgressIndicator(
      value: (currentQuestionIndex + 1) / widget.quiz.questions.length,
      backgroundColor: Colors.white.withOpacity(0.3),
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    );
  }

  Widget _buildQuestionCard(question) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Text(
        question.question,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildAnswerOptions(question) {
    return Expanded(
      child: ListView.builder(
        itemCount: question.options.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedAnswerIndex == index;
          bool isCorrect = index == question.correctAnswerIndex;

          Color buttonColor = Colors.white;
          Color textColor = AppConstants.primaryColor;

          if (showFeedback) {
            if (isCorrect) {
              buttonColor = Colors.green;
              textColor = Colors.white;
            } else if (isSelected && !isCorrect) {
              buttonColor = Colors.red;
              textColor = Colors.white;
            }
          } else if (isSelected) {
            buttonColor = AppConstants.primaryColor;
            textColor = Colors.white;
          }

          return Container(
            margin: EdgeInsets.only(bottom: 15),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: showFeedback
                    ? null
                    : () {
                        setState(() {
                          selectedAnswerIndex = index;
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: textColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode(65 + index),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        question.options[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: selectedAnswerIndex == null
            ? null
            : () {
                if (!showFeedback) {
                  _submitAnswer();
                } else {
                  _nextQuestion();
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppConstants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 5,
        ),
        child: Text(
          showFeedback
              ? (currentQuestionIndex == widget.quiz.questions.length - 1
                  ? 'View Results'
                  : 'Next Question')
              : 'Submit Answer',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _submitAnswer() {
    setState(() {
      showFeedback = true;
      userAnswers.add(selectedAnswerIndex!);
      if (selectedAnswerIndex ==
          widget.quiz.questions[currentQuestionIndex].correctAnswerIndex) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < widget.quiz.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        showFeedback = false;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            quiz: widget.quiz,
            score: score,
            userAnswers: userAnswers,
          ),
        ),
      );
    }
  }
}
