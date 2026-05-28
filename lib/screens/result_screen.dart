import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.restartQuiz,
  });

  final int score;
  final int totalQuestions;

  final VoidCallback restartQuiz;

  @override
  Widget build(BuildContext context) {

    return Center(

      child: Padding(

        padding: const EdgeInsets.all(25),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 120,
            ),

            const SizedBox(height: 30),

            const Text(
              'Quiz Completed!',

              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Your Score: $score/$totalQuestions',

              style: const TextStyle(
                color: Colors.amber,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton.icon(

              onPressed: restartQuiz,

              icon: const Icon(
                Icons.restart_alt,
              ),

              label: const Text(
                'Restart Quiz',
              ),

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    Colors.amber,

                foregroundColor:
                    Colors.black,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}