
import 'dart:math';

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
