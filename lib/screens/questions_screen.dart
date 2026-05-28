import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/answer_button.dart';
import 'package:quiz_app/data/demoquestion.dart';

class QuestionsScreen extends StatefulWidget {

  QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {

  int currentQuestionIndex = 0;
  int score = 0;

  String? selectedAnswer;

  void answerQuestion(String answer) {

    if (selectedAnswer != null) {
      return;
    }

    setState(() {
      selectedAnswer = answer;
    });

    final correctAnswer =
        questions[currentQuestionIndex].answers[0];

    if (answer == correctAnswer) {
      score++;
    }

    Future.delayed(const Duration(seconds: 1), () {

      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });

    });
  }

  Color getAnswerColor(String answer) {

    if (selectedAnswer == null) {
      return const Color.fromARGB(255, 33, 1, 95);
    }

    final correctAnswer =
        questions[currentQuestionIndex].answers[0];

    if (answer == correctAnswer) {
      return Colors.green;
    }

    if (answer == selectedAnswer) {
      return Colors.red;
    }

    return const Color.fromARGB(255, 33, 1, 95);
  }

  @override
  Widget build(BuildContext context) {

    if (currentQuestionIndex >= questions.length) {

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 100,
            ),

            const SizedBox(height: 20),

            Text(
              'Your Score: $score/${questions.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {

                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  selectedAnswer = null;
                });

              },
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      );
    }

    final currentQuestion =
        questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,

      child: Container(
        margin: const EdgeInsets.all(40),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [

            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',

              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),

              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            LinearProgressIndicator(
              value:
                  (currentQuestionIndex + 1) /
                  questions.length,

              backgroundColor: Colors.white24,
              color: Colors.amber,
              minHeight: 10,
            ),

            const SizedBox(height: 40),

            Text(
              currentQuestion.text,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),

              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            ...currentQuestion.shuffledAnswers
                .map((answer) {

              return Padding(
                padding:
                    const EdgeInsets.only(bottom: 12),

                child: ElevatedButton(

                  onPressed: () {
                    answerQuestion(answer);
                  },

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        getAnswerColor(answer),

                    foregroundColor:
                        Colors.white,

                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 20,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30),
                    ),
                  ),

                  child: Text(
                    answer,
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }),

          ],
        ),
      ),
    );
  }
}