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
  String input = '';
  String output = '';

  // Logic to handle button presses
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
          onPressed: () => _onButtonClicked(text),
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
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(input, style: const TextStyle(color: Colors.white, fontSize: 24)),
                  const SizedBox(height: 10),
                  Text(output, style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button("AC", Colors.grey, Colors.black),
              button("A", Colors.grey, Colors.black),
              button("/", Colors.orange, Colors.white),
            ],
          ),
          Row(
            children: [
              button("7", Colors.white10, Colors.white),
              button("8", Colors.white10, Colors.white),
              button("9", Colors.white10, Colors.white),
              button("*", Colors.orange, Colors.white),
            ],
          ),
          Row(
            children: [
              button("4", Colors.white10, Colors.white),
              button("5", Colors.white10, Colors.white),
              button("6", Colors.white10, Colors.white),
              button("-", Colors.orange, Colors.white),
            ],
          ),
          Row(
            children: [
              button("1", Colors.white10, Colors.white),
              button("2", Colors.white10, Colors.white),
              button("3", Colors.white10, Colors.white),
              button("+", Colors.orange, Colors.white),
            ],
          ),
          Row(
            children: [
              button("0", Colors.white10, Colors.white),
              button(".", Colors.white10, Colors.white),
              button("=", Colors.orange, Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}