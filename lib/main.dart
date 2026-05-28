import 'package:flutter/material.dart';
import 'package:quiz_app/screens/questions_screen.dart';
import 'package:quiz_app/screens/start_screen.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() {
    return _QuizAppState();
  }
}

class _QuizAppState extends State<QuizApp> {

  Widget? activeScreen;

  @override
  void initState() {
    super.initState();

    activeScreen = StartScreen(
      startQuiz: switchScreen,
    );
  }

  void switchScreen() {

    setState(() {
      activeScreen = QuestionsScreen();
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: Container(

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 44, 3, 109),
                Color.fromARGB(255, 88, 24, 168),
              ],

              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          child: activeScreen,
        ),
      ),
    );
  }
}