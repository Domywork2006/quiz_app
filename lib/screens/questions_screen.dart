import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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

  // QUIZ STATE
  int currentQuestionIndex = 0;
  int score = 0;

  // ANSWERS
  String? selectedAnswer;
  List<String> selectedAnswers = [];

  // TIMER
  int timeLeft = 10;
  Timer? timer;

  // AUDIO
  final AudioPlayer audioPlayer =
      AudioPlayer();

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  // AUDIO FUNCTION
  Future<void> playSound(
      String soundPath) async {

    await audioPlayer.play(
      AssetSource(soundPath),
    );
  }

  // TIMER FUNCTION
  void startTimer() {

    timer?.cancel();

    timeLeft = 10;

    timer = Timer.periodic(
      const Duration(seconds: 1),

      (timer) {

        if (timeLeft > 0) {

          setState(() {
            timeLeft--;
          });

        } else {

          timer.cancel();

          answerQuestion('');
        }
      },
    );
  }

  // NEXT QUESTION
  void nextQuestion() {

    timer?.cancel();

    setState(() {

      currentQuestionIndex++;
      selectedAnswer = null;

    });

    if (currentQuestionIndex <
        questions.length) {

      startTimer();
    }
  }

  // ANSWER FUNCTION
  void answerQuestion(String answer) async {

    if (selectedAnswer != null) {
      return;
    }

    timer?.cancel();

    setState(() {

      selectedAnswer = answer;

      selectedAnswers.add(answer);

    });

    final correctAnswer =
        questions[currentQuestionIndex]
            .answers[0];

    // CORRECT ANSWER
    if (answer == correctAnswer) {

      score++;

      await playSound(
        'audio/correct_sound.wav',
      );

    } else {

      await playSound(
        'audio/wrong_sound.wav',
      );
    }

    Future.delayed(
      const Duration(seconds: 1),

      () {
        nextQuestion();
      },
    );
  }

  // ANSWER COLORS
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

  // RESTART QUIZ
  void restartQuiz() {

    setState(() {

      currentQuestionIndex = 0;
      score = 0;

      selectedAnswer = null;

      selectedAnswers.clear();

    });

    startTimer();
  }

  @override
  void dispose() {

    timer?.cancel();

    audioPlayer.dispose();

    super.dispose();
  }

  // RESULT SCREEN
  Widget buildResultScreen() {

    return Padding(

      padding: const EdgeInsets.all(20),

      child: Column(

        children: [

          const SizedBox(height: 60),

          const Icon(
            Icons.emoji_events,
            color: Colors.amber,
            size: 100,
          ),

          const SizedBox(height: 20),

          Text(
            'Your Score: $score/${questions.length}',

            style: const TextStyle(
              color: Colors.amber,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          Expanded(

            child: ListView.builder(

              itemCount: questions.length,

              itemBuilder: (context, index) {

                final question =
                    questions[index];

                final correctAnswer =
                    question.answers[0];

                final userAnswer =
                    selectedAnswers[index];

                final isCorrect =
                    userAnswer ==
                        correctAnswer;

                return Container(

                  margin:
                      const EdgeInsets.only(
                    bottom: 20,
                  ),

                  padding:
                      const EdgeInsets.all(20),

                  decoration: BoxDecoration(

                    color:
                        const Color.fromARGB(
                            40,
                            255,
                            255,
                            255),

                    borderRadius:
                        BorderRadius.circular(
                            25),
                  ),

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      Row(

                        children: [

                          Icon(

                            isCorrect
                                ? Icons.check_circle
                                : Icons.cancel,

                            color: isCorrect
                                ? Colors.green
                                : Colors.red,
                          ),

                          const SizedBox(
                              width: 10),

                          Expanded(

                            child: Text(

                              question.text,

                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Text(
                        'Your Answer: $userAnswer',

                        style: TextStyle(
                          color: isCorrect
                              ? Colors.green
                              : Colors.red,

                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Correct Answer: $correctAnswer',

                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

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
                    BorderRadius.circular(
                        30),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // QUIZ SCREEN
  Widget buildQuizScreen() {

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

            // TIMER
            Center(

              child: Container(

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),

                decoration: BoxDecoration(

                  color: timeLeft <= 3
                      ? Colors.red
                      : Colors.amber,

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(

                  '$timeLeft s',

                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // QUESTION COUNT
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

            // PROGRESS BAR
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

            // QUESTION CARD
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

            // ANSWERS
            ...currentQuestion
                .shuffledAnswers
                .map((answer) {

              return Padding(

                padding:
                    const EdgeInsets.only(
                  bottom: 15,
                ),

                child: ElevatedButton(

                  onPressed: () async {

                    await playSound(
                      'audio/click_sound.wav',
                    );

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

  @override
  Widget build(BuildContext context) {

    if (currentQuestionIndex >=
        questions.length) {

      return buildResultScreen();
    }

    return buildQuizScreen();
  }
}