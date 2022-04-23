import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result(this.totalScore, this.reset, {Key? key}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final totalScore;
  final VoidCallback reset;
  String get resultPhrase {
    String resultText;

    if (totalScore >= 40) {
      resultText = "You are best your Score is";
    } else if (totalScore >= 25) {
      resultText = "Avarage Performance your Score is";
    } else {
      resultText = "Poor performance your Score is";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(children: [
        Text(resultPhrase),
        Text(
          totalScore.toString(),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: reset,
          child: const Text("Reset Quiz"),
          style: ElevatedButton.styleFrom(primary: Colors.amber),
        )
      ]),
    );
  }
}
