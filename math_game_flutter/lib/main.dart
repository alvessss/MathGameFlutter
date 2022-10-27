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

class _Log {
  final List<String> _last10Results = [];
  final List<Text> textWidgets = [];
  final List<Container> textWidgetsContainers = [];
  
  final Color wrongResultColor = Colors.red;
  final Color rightResultColor = Colors.green;

  int _index = 0;
  static const int max = 10;

  void _fill() {
    if (textWidgetsContainers.isNotEmpty) {
      return;
    }
    while (_index < max) {
      _last10Results.add("0");
      textWidgetsContainers.add(
        Container(
          height: 20,
          width: 100,
          child: const Text(
            "",
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        )
      );
      _index++;
    }
    _index = 0;
  }

  void _addResultToStack(int index, String result, Color color) {
    textWidgetsContainers[index] = Container(
      height: 20,
      width: 100,
      child: Text(
        result,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: color,
          fontSize: 10
        ),
      ),
    );
  }

  void addResultToLog(String userResult, int actualResult) {
    if (_index == max) {
      for (var i = 0; i < max; i++) {
        if ((i + 1) == max) {
          _last10Results[i] = userResult;
        } else {
          _last10Results[i] = _last10Results[i + 1];
        }

        if (int.parse(userResult) == actualResult) {
          _addResultToStack(i, _last10Results[i], rightResultColor);
        } else {
          _addResultToStack(i, _last10Results[i], wrongResultColor);
        }
      }
    } else {
        _last10Results.add(userResult);

        if (int.parse(userResult) == actualResult) {
          _addResultToStack(_index, userResult, rightResultColor);
        } else {
          _addResultToStack(_index, userResult, wrongResultColor);
        }
        _index++;
    }
  }
}

class _HomePageState extends State<HomePage> {
  final ExpressionGenerator exp = ExpressionGenerator();
  final TextEditingController textFieldResultController = TextEditingController();

  final _Log resultsLog = _Log();
  
  @override Widget build(BuildContext context) {
    exp.generate();
    resultsLog._fill();

    final AppBar appTitleBar = AppBar(title: Text(widget.title));
    final Column logColumn = Column(
        children: resultsLog.textWidgetsContainers
    );

    final Container containerA = Container(
      width: 60,
      height: 50,
      child: Text(
        exp.a.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 45
        ),
      ),
    );

    final Container containerB = Container(
      width: 60,
      height: 50,
      child: Text(
        exp.b.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 45
        ),
      ),
    );

    final Container containerOperator = Container(
      width: 60,
      height: 50,
      child: Text(
        exp.operator,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.blueGrey,
          fontSize: 45
        ),
      ),
    );

    final Container containerEqualSign = Container(
      width: 60,
      height: 50,
      child: const Text(
        "=",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 45
        ),
      ),
    );

    final TextField textFieldResult = TextField(
      textAlign: TextAlign.center,
      controller: textFieldResultController,
    );
    
    final Container textFieldContainer = Container(
      width: 80,
      child: textFieldResult,
    );

    final Row expressionRow = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [containerA, containerOperator, containerB, containerEqualSign, textFieldContainer]);

    final Container mainContentCenter = Container(
      child: Column(
        children: [
          Container(
            color: Colors.blueGrey,
            height: 40,
            width: 100,
            child: logColumn,
          ),
          expressionRow
        ]
        ,
      ),
    );

    final FloatingActionButton genNewExpBtn = FloatingActionButton(
        onPressed: () {
          setState(() {
            resultsLog.addResultToLog(textFieldResultController.text, exp.result);
            exp.generate();
            textFieldResultController.clear();
          });
        }
    );

    return Scaffold(
        appBar: appTitleBar,
        floatingActionButton: genNewExpBtn,
        body: mainContentCenter
    );
  }
}
