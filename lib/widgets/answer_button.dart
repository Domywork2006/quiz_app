import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {

  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,

      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 33, 1, 95),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),

      child: Text(
        answerText,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}