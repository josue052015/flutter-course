import 'package:flutter/material.dart';
import 'package:hello_word_app/src/screens/counter_functions.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterFunctionsScreen(),
    );
  }
}
