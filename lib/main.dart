import 'package:flutter/material.dart';

// Variables to hold numbers and operation strings
double num1 = 0.0;
double num2 = 0.0;

// Stores the user input
var input = ''; 

// Stores the calculation result
var output = '';

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
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      ),
    );
  }
}