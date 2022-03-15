class Question {
  final String questionText;
  final bool questionAnswer;

  Question({required this.questionAnswer, required this.questionText});

  bool isCorrect(bool userAnswer){
    return this.questionAnswer == userAnswer;
  }
}