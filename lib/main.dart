import 'package:flutter/material.dart';
import 'package:flutter_calc/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalcApp());
}

class CalcApp extends StatelessWidget {
  const CalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'RES',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: Text(
                  userQuestion,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(
                  userAnswer,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                // Clear Button
                if (index == 0) {
                  return CalcButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = '';
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.green,
                    textColor: Colors.white,
                  );
                  // Delete Button
                } else if (index == 1) {
                  return CalcButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion =
                            userQuestion.substring(0, userQuestion.length - 1);
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.red,
                    textColor: Colors.white,
                  );
                }
                // Equal Button
                else if (index == buttons.length - 1) {
                  return CalcButton(
                    buttonTapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                  );
                  // Rest of the button
                } else {
                  return CalcButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])
                        ? Colors.deepPurple
                        : Colors.white,
                    textColor: isOperator(buttons[index])
                        ? Colors.white
                        : Colors.deepPurple,
                  );
                }
              }),
        ),
      ]),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    
    ExpressionParser p = GrammarParser();
    Expression exp = p.parse(finalQuestion);
    
    ContextModel cm = ContextModel();
    RealEvaluator evaluator = RealEvaluator(cm);
    num eval = evaluator.evaluate(exp);
    
    userAnswer = eval.toString();
  }
}