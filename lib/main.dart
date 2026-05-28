import 'package:flutter/material.dart';
import 'package:quiz_app/screens/category_screen.dart';
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

  // START SCREEN -> CATEGORY SCREEN
  void switchScreen() {

    setState(() {

      activeScreen = CategoryScreen(
        selectCategory: startQuiz,
      );

    });
  }

  // CATEGORY SCREEN -> QUIZ SCREEN
  void startQuiz(String category) {

    setState(() {

      activeScreen = QuestionsScreen();

    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor:
            const Color(0xFF1E1E2C),
      ),

      home: Scaffold(

        body: Container(

          decoration: const BoxDecoration(

            gradient: LinearGradient(

              colors: [

                Color(0xFF1E1E2C),
                Color(0xFF2D1B69),
                Color(0xFF6C63FF),

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