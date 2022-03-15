import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("I am poor"),
          backgroundColor: Colors.purple.shade700,
        ),
        body: Center(
          child: Image.asset("assests/poor_image.png"),
        ),
      ),
    );
  }
}
