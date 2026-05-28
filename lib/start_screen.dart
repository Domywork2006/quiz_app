import 'package:flutter/material.dart';


class StartScreen extends StatelessWidget {
  StartScreen( this. startQuiz ,{super.key});
final void Function() startQuiz;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/logo1.png', width:300 ,),
          const SizedBox(height: 60,),
          const Text('Learn Flutter the fun way!', style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 195, 183, 202)
          )
          ),
          const SizedBox(height: 30,),
          OutlinedButton.icon(onPressed: () {startQuiz();},
          style: OutlinedButton.styleFrom(foregroundColor:Color.fromARGB(255, 157, 158, 168)),
          icon: const Icon(Icons.arrow_right_alt) 
          , label: const Text('Start Quiz!'))
        ],

      ),  
    );
  }
}