import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../models/game_state.dart';
import '../models/question.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final List<Question> allQuestions;

  QuestionWidget({required this.question, required this.allQuestions});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Color? _color;
  bool _isLocked = false;
  final FlutterTts flutterTts = FlutterTts();
  late BuildContext _context;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _context = context;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.allQuestions.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    List<String> imageOptions =
        widget.allQuestions.map((q) => q.imagePath).toList();
    imageOptions.shuffle();

    return Center(
      child: Card(
        margin: EdgeInsets.all(8),
        color: _color,
        child: ListTile(
          title: Text(widget.question.word),
          // leading: Image.asset(widget.question.imagePath),
          onTap: _isLocked
              ? null
              : () async {
                  await flutterTts.speak(widget.question.word);
                  _showOptionsDialog(context, imageOptions);
                },
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, List<String> imageOptions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 50, 215, 250),
          title: Text(
            textAlign: TextAlign.center,
            'Select the correct image',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: Container(
            decoration: BoxDecoration(
                color: Colors.amber.shade50,
                border: Border.all(width: 6, color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10)),
            width: double.maxFinite,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: imageOptions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //   if (imageOptions[index] == widget.question.imagePath) {
                    //   _color = Colors.green;

                    // } else {
                    //   _color = Colors.red;

                    // }
                    _handleSelection(imageOptions[index]);
                    Navigator.of(context).pop(); // Close the dialog
                    // Future.delayed(Duration(seconds: 1), () {
                    //   if (mounted) {
                    //     Navigator.of(context).pop(); // Close the dialog
                    //   }
                    // });
                  },
                  child: Image.asset(imageOptions[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _handleSelection(String selectedImagePath) {
    final gameState = Provider.of<GameState>(_context, listen: false);

    setState(() {
      _isLocked = true;
      if (selectedImagePath == widget.question.imagePath) {
        _color = Colors.green;
        gameState.incrementCorrectAnswers();
      } else {
        _color = Colors.red;
        gameState.incrementWrongAttempts();
      }
      gameState.addAnswer(
          widget.question.word, selectedImagePath == widget.question.imagePath);
    });

    if (gameState.allQuestionsAnswered(widget.allQuestions.length)) {
      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(_context).pushReplacementNamed('/results');
        }
      });
    }
  }
}
