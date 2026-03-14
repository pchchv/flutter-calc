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
      home: const MyCalculator(),
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
  var input = '';
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

  Widget button(String text, Color color, Color tcolor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: text.isEmpty ? null : () => _onButtonClicked(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: tcolor, 
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button("AC", Colors.black, Colors.orangeAccent),
              button("A", Colors.black, Colors.orangeAccent),
              button("", Colors.transparent, Colors.white),
              button("/", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("7", Colors.black, Colors.white),
              button("8", Colors.black, Colors.white),
              button("9", Colors.black, Colors.white),
              button("*", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("4", Colors.black, Colors.white),
              button("5", Colors.black, Colors.white),
              button("6", Colors.black, Colors.white),
              button("-", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("1", Colors.black, Colors.white),
              button("2", Colors.black, Colors.white),
              button("3", Colors.black, Colors.white),
              button("+", Colors.black, Colors.orangeAccent),
            ],
          ),
          Row(
            children: [
              button("%", Colors.black, Colors.orangeAccent),
              button("0", Colors.black, Colors.white),
              button(".", Colors.black, Colors.white),
              button("=", Colors.orangeAccent, Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}