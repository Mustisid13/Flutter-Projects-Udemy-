import 'package:flutter/material.dart';
import 'package:quizzler/data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const QuizPage()
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper= [];
  int questionNumber =0;
  bool showResult = false;
  int correctCount =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: showResult? ResultPage(correctCount:correctCount) :Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex:1,child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Text((questionNumber+1).toString(),style: TextStyle(fontSize: 40,color: Colors.black),),
            )),
            Expanded(flex:5,child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(child: Text(questions[questionNumber].questionText,style: const TextStyle(color: Colors.white,fontSize: 25,),textAlign: TextAlign.center,)),
            )),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: MaterialButton(onPressed: ()=>checkAndMoveToNextQuestion(true),child: const Text("True",style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),),color: Colors.green,),
            )),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: MaterialButton(onPressed: ()=>checkAndMoveToNextQuestion(false),child: const Text("False",style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),),color: Colors.red,),
            )),
            Row(
              children: scoreKeeper
            )
          ]
        ),
      ),
    );
  }

  checkAndMoveToNextQuestion(bool answer){
    final isCorrect = questions[questionNumber].isCorrect(answer);

      if (isCorrect) {
        setState(() {
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
          ));
          correctCount++;
          if(questionNumber < questions.length -1){
          questionNumber++;
          } else{
            questionNumber = 0;
            scoreKeeper.clear();
            Alert(
                context: context,
                type: AlertType.success,
                title: 'You Scored',
                desc: "$correctCount / ${questions.length}"
            ).show();
          }

          });
      } else {
        setState(() {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
          ));
          if(questionNumber < questions.length -1){
            questionNumber++;
          } else{
            Alert(
                context: context,
                type: AlertType.success,
                title: 'You Scored',
                desc: "$correctCount / ${questions.length}"
            ).show();
          }

        });
      }
    if(questionNumber > questions.length -1){
      Alert(
        context: context,
        type: AlertType.success,
        title: 'You Scored',
        desc: "$correctCount / ${questions.length}"
      ).show();
    }
  }
}

class ResultPage extends StatelessWidget {
  final int correctCount;
  const ResultPage({Key? key, required this.correctCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: correctCount/questions.length>0.5? Colors.green : Colors.red,
        elevation: 20,
        child: SizedBox(
          height: MediaQuery.of(context).size.height *0.3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("You Scored: $correctCount/${questions.length}",style: const TextStyle(color: Colors.white,fontSize: 30),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: correctCount/questions.length>0.5? const Text("Well Done!!",style: TextStyle(color: Colors.white,fontSize: 25),) : Text("OOPS!! You Failed",style: TextStyle(color: Colors.white,fontSize: 25),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
