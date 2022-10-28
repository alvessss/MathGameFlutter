import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ExpressionGenerator.dart';

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


class _HomePageState extends State<HomePage> {
  final ExpressionGenerator exp = ExpressionGenerator();
  final TextEditingController textFieldResultController = TextEditingController();


  @override Widget build(BuildContext context) {
    // first expression generated automatically
    exp.generate();

    return Scaffold(
        appBar: AppBar(
          title: const SizedBox(
            width: double.infinity, // match parent
            child: Text("Math Game", textAlign: TextAlign.center),
          ),

        ),

        body: Container(
          width: 300,
          child: Column(
            children: [
              Column(
                children: List.generate(5, (index) =>
                    SizedBox(
                        width: 300,
                        child: Text("")
                    )
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    child:
                      Text(
                        "${exp.a} ${exp.operator} ${exp.b} = ",
                        style: const TextStyle(fontSize: 35, color: Colors.blueGrey)
                      ),
                  ),
                  const SizedBox(
                      width: 100,
                      child: TextField()
                  ),
                ],
              ),
            ],
          ),
        ),

    );

  }
}
