import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/input_page.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String bmiresult;
  final String resultText;
  final String interpretationText;
  const ResultPage({Key? key,required this.bmiresult,required this.resultText,required this.interpretationText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI CALCULATOR"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(15),
            child: const Text('Your Result',style: kTitleTextStyle,),
          )),
          Expanded(child: ReusableCard(
            color: kActiveContainerColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(resultText.toUpperCase(),style: kResultTextStyle,),
                Text(bmiresult,style: kBMITextStyle,),
                Text(interpretationText,style: const TextStyle(fontSize: 22),textAlign: TextAlign.center,),
              ],
            ),
          ),flex: 5,
          ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: const Text("RE-CALCULATE",style: kLargeButtonTextStyle,),
              width: double.infinity,
              height: 80,
              decoration: const BoxDecoration(color: Color(0xffeb1555)),
            ),
          )
        ],
      ),
    );
  }
}
