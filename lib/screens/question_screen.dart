import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/question.dart';
import '../widgets/question_widget.dart';

class QuestionScreen extends StatefulWidget {
  final List<Question> questions;

  QuestionScreen({required this.questions}) {
    questions.shuffle(); // Shuffle the questions list
  }

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
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
                  itemCount: widget.questions.length,
                  itemBuilder: (context, index) {
                    return QuestionWidget(
                      question: widget.questions[index],
                      allQuestions: widget.questions,
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
