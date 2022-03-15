import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: const DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePageState();
}



class _DicePageState extends State<DicePage> {
  int leftDice = 1;
  int rightDice = 1;

  changeDice(){
    setState(() {
      leftDice = Random().nextInt(6) +1;
      rightDice = Random().nextInt(6) +1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: TextButton(onPressed:changeDice,
          child: Image.asset("images/dice$leftDice.png"))),
          Expanded(child: TextButton(onPressed:changeDice,child: Image.asset("images/dice$rightDice.png"))),
        ],
      ),
    );
  }
}
