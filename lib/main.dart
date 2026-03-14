import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyCalculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  // Variables to hold numbers and operation strings
  double num1 = 0.0;
  double num2 = 0.0;
  
  // Stores the user input
  var input = '';
  
  // Stores the calculation result
  var output = '';
  
  void _onButtonClicked(String value) {
    setState(() {
      if (value == "AC") {
        input = '';
        output = '';
      } else if (value == "A") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == "=") {
        if (input.isNotEmpty) {
          try {
            final parser = GrammarParser();
            final expression = parser.parse(input);
            final evaluator = RealEvaluator();
            final num finalValue = evaluator.evaluate(expression);
            output = finalValue.toString();
            if (output.endsWith(".0")) {
              output = output.substring(0, output.length - 2);
            }
          } catch (e) {
            output = "Error";
          }
        }
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(input, style: TextStyle(fontSize: 24)),
          Text(output, style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () => _onButtonClicked("1"), // This "references" the function
            child: Text("1"),
          ),
          ElevatedButton(
            onPressed: () => _onButtonClicked("="),
            child: Text("="),
          ),
        ],
      ),
    );
  }
}