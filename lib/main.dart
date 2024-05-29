import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_image_matching_game/models/question.dart';
import 'models/game_state.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Word Image Matching Game',
        initialRoute: '/questions',
        routes: {
          '/questions': (context) =>
              QuestionScreen(questions: generateQuestions()),
          '/results': (context) => ResultScreen(),
        },
      ),
    );
  }

  List<Question> generateQuestions() {
    return [
      Question(word: 'banana', imagePath: 'assets/banana.png'),
      Question(word: 'bear', imagePath: 'assets/bear.png'),
      Question(word: 'key', imagePath: 'assets/key.png'),
      Question(word: 'dog', imagePath: 'assets/dog.png'),
      Question(word: 'box', imagePath: 'assets/box.png'),
      Question(word: 'bird', imagePath: 'assets/bird.png'),
      Question(word: 'apples', imagePath: 'assets/apples.png'),
      Question(word: 'carrot', imagePath: 'assets/carrot.png'),
      // Add more questions as needed
    ];
  }
}
