import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';

class Quize extends StatelessWidget {
  const Quize(this._questionIndex, this.answerQuestion, this.questions,
      {Key? key})
      : super(key: key);

  final List<Map<String, Object>> questions;
  final int _questionIndex;
  final Function answerQuestion;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Question(questions[_questionIndex]['questionText'] as String),
          ...(questions[_questionIndex]['answer'] as List<Map<String, Object>>)
              .map((answer) {
            return Answer(
              answer['text'] as String,
              () => answerQuestion(answer['score'] as int),
            );
          }).toList()
        ],
      ),
    );
  }
}
