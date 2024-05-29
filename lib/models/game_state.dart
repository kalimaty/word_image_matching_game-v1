import 'package:flutter/material.dart';

class GameState with ChangeNotifier {
  int _correctAnswers = 0;
  int _wrongAttempts = 0;
  List<Map<String, dynamic>> _answers = [];

  int get correctAnswers => _correctAnswers;
  int get wrongAttempts => _wrongAttempts;
  List<Map<String, dynamic>> get answers => _answers;

  void incrementCorrectAnswers() {
    _correctAnswers++;
    notifyListeners();
  }

  void incrementWrongAttempts() {
    _wrongAttempts++;
    notifyListeners();
  }

  void addAnswer(String word, bool isCorrect) {
    _answers.add({'word': word, 'isCorrect': isCorrect});
    notifyListeners();
  }

  bool allQuestionsAnswered(int totalQuestions) {
    return _answers.length == totalQuestions;
  }

  void resetGame() {
    _correctAnswers = 0;
    _wrongAttempts = 0;
    _answers = [];
    notifyListeners();
  }
}
