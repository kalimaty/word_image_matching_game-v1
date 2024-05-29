import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Consumer<GameState>(
        builder: (context, gameState, child) {
          final totalAttempts =
              gameState.correctAnswers + gameState.wrongAttempts;
          final percentage = totalAttempts > 0
              ? (gameState.correctAnswers / totalAttempts) * 100
              : 0;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DataTable(
                      // dataRowHeight: 60.0,
                      border: TableBorder.all(color: Colors.green, width: 2),
                      columns: [
                        DataColumn(label: Text('Metric')),
                        DataColumn(label: Text('Value')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('Correct Answers')),
                          DataCell(Text('${gameState.correctAnswers}')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Wrong Attempts')),
                          DataCell(Text('${gameState.wrongAttempts}')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Percentage')),
                          DataCell(Text('${percentage.toStringAsFixed(2)}%')),
                        ]),
                      ],
                    ),
                    SizedBox(height: 20),
                    DataTable(
                      dataRowHeight: 70.0,
                      border: TableBorder.all(color: Colors.blue, width: 2),
                      columns: [
                        DataColumn(label: Text('Word')),
                        DataColumn(label: Text('Result')),
                      ],
                      rows: gameState.answers.map((answer) {
                        return DataRow(
                          cells: [
                            DataCell(Text(answer['word'])),
                            DataCell(
                              Text(
                                answer['isCorrect'] ? 'Correct' : 'Wrong',
                                style: TextStyle(
                                  color: answer['isCorrect']
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // background
                        foregroundColor: Colors.white, // foreground
                      ),
                      onPressed: () {
                        context.read<GameState>().resetGame();
                        Navigator.of(context)
                            .pushReplacementNamed('/questions');
                      },
                      child: Text('Restart'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
