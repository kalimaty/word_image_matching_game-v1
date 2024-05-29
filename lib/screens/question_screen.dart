import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/question.dart';
import '../widgets/question_widget.dart';

class QuestionScreen extends StatelessWidget {
  final List<Question> questions;

  QuestionScreen({required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Words with Images'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<GameState>(
              builder: (context, gameState, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Correct: ${gameState.correctAnswers}'),
                    Text('Errors: ${gameState.wrongAttempts}'),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<GameState>(
              builder: (context, gameState, child) {
                return ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return QuestionWidget(
                      question: questions[index],
                      allQuestions: questions,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
