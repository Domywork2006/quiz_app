import 'package:flutter/material.dart';
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
        questions[currentQuestionIndex]
            .answers[0];

    if (answer == correctAnswer) {
      score++;
    }

    Future.delayed(
      const Duration(seconds: 1),
      () {

        setState(() {
          currentQuestionIndex++;
          selectedAnswer = null;
        });

      },
    );
  }

  Color getAnswerColor(String answer) {

    if (selectedAnswer == null) {
      return const Color(0xFF6C63FF);
    }

    final correctAnswer =
        questions[currentQuestionIndex]
            .answers[0];

    if (answer == correctAnswer) {
      return Colors.green;
    }

    if (answer == selectedAnswer) {
      return Colors.red;
    }

    return const Color(0xFF6C63FF);
  }

  @override
  Widget build(BuildContext context) {

    if (currentQuestionIndex >=
        questions.length) {

      return Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 100,
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
              'Your Score: $score/${questions.length}',

              style: const TextStyle(
                color: Colors.amber,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton.icon(

              onPressed: () {

                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  selectedAnswer = null;
                });

              },

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
      );
    }

    final currentQuestion =
        questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,

      child: Container(

        margin: const EdgeInsets.all(25),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [

            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',

              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),

              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            ClipRRect(

              borderRadius:
                  BorderRadius.circular(20),

              child: LinearProgressIndicator(

                value:
                    (currentQuestionIndex + 1) /
                    questions.length,

                backgroundColor:
                    Colors.white24,

                color: Colors.amber,

                minHeight: 12,
              ),
            ),

            const SizedBox(height: 50),

            // PREMIUM QUESTION CARD
            Container(

              padding:
                  const EdgeInsets.all(30),

              decoration: BoxDecoration(

                borderRadius:
                    BorderRadius.circular(30),

                color:
                    const Color.fromARGB(
                        40, 255, 255, 255),

                border: Border.all(
                  color: Colors.white24,
                  width: 1.5,
                ),

                boxShadow: const [

                  BoxShadow(
                    color:
                        Color.fromARGB(
                            120, 103, 58, 183),

                    blurRadius: 25,
                    spreadRadius: 3,
                  ),
                ],
              ),

              child: AnimatedSwitcher(

                duration:
                    const Duration(
                  milliseconds: 500,
                ),

                child: Text(
                  currentQuestion.text,

                  key: ValueKey(
                    currentQuestion.text,
                  ),

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,

                    height: 1.4,
                  ),

                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 40),

            ...currentQuestion
                .shuffledAnswers
                .map((answer) {

              return Padding(

                padding:
                    const EdgeInsets.only(
                  bottom: 15,
                ),

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

                    elevation: 12,

                    shadowColor:
                        Colors.deepPurple,

                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius.circular(
                        25,
                      ),
                    ),
                  ),

                  child: Text(

                    answer,

                    textAlign:
                        TextAlign.center,

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w600,
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