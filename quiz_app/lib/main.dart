import 'package:flutter/material.dart';
import 'package:quiz_app/quize.dart';
import 'package:quiz_app/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final questions = const [
    {
      'questionText': 'What is your favorite color ? ',
      'answer': [
        {'text': 'Blue', 'score': 4},
        {'text': 'Green', 'score': 5},
        {'text': 'Red', 'score': 9},
        {'text': 'Orange', 'score': 10},
      ],
    },
    {
      'questionText': 'What is your favorite animal ?',
      'answer': [
        {'text': 'Lion', 'score': 7},
        {'text': 'Dog', 'score': 8},
        {'text': 'Elephant', 'score': 4},
        {'text': 'Monkey', 'score': 10},
      ],
    },
    {
      'questionText': 'Which is your favorite Book ?',
      'answer': [
        {'text': 'Fountain Head', 'score': 10},
        {'text': '1984', 'score': 8},
        {'text': 'Secret', 'score': 6},
        {'text': 'Rich Dad Poor Dad', 'score': 7},
      ],
    },
    {
      'questionText': 'Which is your favorite Movie?',
      'answer': [
        {'text': 'Break', 'score': 7},
        {'text': 'TENET', 'score': 8},
        {'text': 'No Time To Die', 'score': 4},
        {'text': 'DUNE', 'score': 10},
      ],
    },
  ];
  var totalScore = 0;
  var _questionIndex = 0;
  void _answerQuestion(int score) {
    totalScore += score;
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  void _resetQuiz() {
    setState(() {
      totalScore = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Quiz App"),
        ),
        body: _questionIndex < questions.length
            ? Quize(_questionIndex, _answerQuestion, questions)
            : Result(totalScore, _resetQuiz),
      ),
    );
  }
}
