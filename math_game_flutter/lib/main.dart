import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  // Esta Ferramenta é a raiz da sua aplicação
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

class _HomePageState extends State<HomePage> {
  final Random random = Random();
  final int MAX = 100;
  
  int currentA = 0;
  int currentB = 0;
  String currentOperator = "+";
  static List<String> availableOperators = ["-", "+", "/", "*"];

  void generateNewExpression() {
    setState(() {
      int randOperator = random.nextInt(availableOperators.length); // temp
      currentA = random.nextInt(MAX);
      currentB = random.nextInt(MAX);
      currentOperator = availableOperators[randOperator];
    });
  }

  @override
  Widget build(BuildContext context) {
    generateNewExpression();

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
                '$currentA',
                style: Theme.of(context).textTheme.headline4,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Text(
                  currentOperator,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Text(
                '$currentB',
                style: Theme.of(context).textTheme.headline4,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0),
                  decoration: InputDecoration(
                    constraints: BoxConstraints.tightFor(
                      width: 60.00,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          generateNewExpression();
        },
      ),
    );
  }
}
