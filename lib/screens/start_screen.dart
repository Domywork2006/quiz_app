import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {

  const StartScreen({
    super.key,
    required this.startQuiz,
  });

  final VoidCallback startQuiz;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          const Icon(
            Icons.quiz,
            size: 120,
            color: Colors.amber,
          ),

          const SizedBox(height: 30),

          const Text(
            'Flutter Quiz App',

            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Test your knowledge',

            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 40),

          ElevatedButton.icon(

            onPressed: startQuiz,

            icon: const Icon(
              Icons.arrow_right_alt,
            ),

            label: const Text(
              'Start Quiz',
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,

              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}