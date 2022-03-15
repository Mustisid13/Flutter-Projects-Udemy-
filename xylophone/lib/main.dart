import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Xylophone(),
    );
  }
}

class Xylophone extends StatefulWidget {
  const Xylophone({Key? key}) : super(key: key);

  @override
  _XylophoneState createState() => _XylophoneState();
}

class _XylophoneState extends State<Xylophone> {
  List colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.purple
  ];
  List notes = [
    "note1.wav",
    "note2.wav",
    "note3.wav",
    "note4.wav",
    "note5.wav",
    "note6.wav",
    "note7.wav"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: notes
                .map((e) => Expanded(
                  child: MaterialButton(
                        onPressed: () {
                          final player = AudioCache();
                          player.play(e);
                        },
                        color: colors[notes.indexOf(e)],
                      ),
                ))
                .toList()),
      ),
    );
  }
}
