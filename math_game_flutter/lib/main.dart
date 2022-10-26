import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const HomePage(title: 'Math Game'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Operator {
  addiction, subtraction, multiplication, division
}

class ExpressionGenerator {
  final Random randomNumberGenerator = Random();
  static const int max = 100;

  int a = 0;
  int b = 0;
  String operator = "+";
  Operator _operator = Operator.addiction;

  Operator _getRandomOperator() {
    return Operator.values[
      randomNumberGenerator.nextInt(Operator.values.length)
    ];
  }

  void generate() {
    _operator = _getRandomOperator();
    a = randomNumberGenerator.nextInt(max);
    b = randomNumberGenerator.nextInt(max);

    switch (_operator) {
      case Operator.addiction:
        operator = "+";
        break;
      case Operator.subtraction:
        operator = "-";
        // avoid negative numbers
        if (b > a) {
          int temp = b;
          b = a;
          a = temp;
        }
        break;
      case Operator.multiplication:
        operator = "*";
        break;
      case Operator.division:
        operator = "/";
        // avoid float numbers
        int multiplicationResult = a * b;
        b = a;
        a = multiplicationResult;
        break;
    }
  }
}

class _HomePageState extends State<HomePage> {
  final ExpressionGenerator expression = ExpressionGenerator();

  TextEditingController myTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    expression.generate();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          color: Colors.white70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                expression.a.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Text(
                  expression.operator,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text(
                expression.b.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30.0),
                  decoration: const InputDecoration(
                    constraints: BoxConstraints.tightFor(
                      width: 60.00,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  controller: myTextFieldController,
                ),
              ),
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            expression.generate();
            myTextFieldController.clear();
          });
        },
      ),
    );
  }
}
