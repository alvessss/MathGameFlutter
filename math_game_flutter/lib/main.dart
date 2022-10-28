import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: List.generate(5, (index) =>
                    SizedBox(
                        width: 300,
                        child: Text("hello world $index")
                    )
                ),
              ),
              Row(
                children: const [
                  SizedBox(
                    child: Text("113 + 12 = ", style: TextStyle(fontSize: 35, color: Colors.blueGrey)),
                  ),
                  SizedBox(
                      width: 100,
                      child: TextField()
                  ),
                ],
              )
            ],
          ),
        ),

    );

  }
}
