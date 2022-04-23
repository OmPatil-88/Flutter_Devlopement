import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  const Answer(this.answer, this.answerptr, {Key? key}) : super(key: key);

  final String answer;
  final VoidCallback answerptr;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
          child: Text(answer),
          onPressed: answerptr),
    );
  }
}
