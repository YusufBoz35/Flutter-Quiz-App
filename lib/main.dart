import 'package:flutter/material.dart';
import 'package:quizzer_app/quizzerBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizzerBrain quizzerBrain = QuizzerBrain();

void main() => runApp(const Quizzer());

class Quizzer extends StatelessWidget {
  const Quizzer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    setState(() {
      bool currentAnswer = quizzerBrain.qetQuestionAnswer();
      if (currentAnswer == userPickedAnswer) {
        scorekeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scorekeeper.add(const Icon(
          Icons.cancel,
          color: Colors.red,
        ));
      }
      quizzerBrain.nextQuestion();
    });
  }

  void checkNumber() {
    var currentNumber = quizzerBrain.getQuestionNumber();
    if (currentNumber == 12) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Test has been finished",
        desc: "You can solve it again",
        buttons: [
          DialogButton(
            child: Text(
              "Retry",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(10.0),
            child: Center(
              child: Text(
                quizzerBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkNumber();
                checkAnswer(true);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text('True'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                checkNumber();
                checkAnswer(false);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              child: const Text('False'),
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}
