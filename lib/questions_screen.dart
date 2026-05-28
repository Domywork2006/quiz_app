import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/demoquestion.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  void answerQuestion(String selectedAnswer) {

    final correctAnswer =
        questions[currentQuestionIndex].answers[0];

    if (selectedAnswer == correctAnswer) {
      score++;
    }

    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {

    // END SCREEN
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
                });
              },
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // PROGRESS TEXT
            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            // PROGRESS BAR
            LinearProgressIndicator(
              value:
                  (currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.white24,
              color: Colors.amber,
              minHeight: 10,
            ),

            const SizedBox(height: 40),

            // QUESTION
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

            // ANSWERS
            ...currentQuestion.shuffledAnswers.map((answer) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AnswerButton(
                  answerText: answer,
                  onTap: () {
                    answerQuestion(answer);
                  },
                ),
              );
            }),

          ],
        ),
      ),
    );
  }
}