import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// Hangman is a stateful widget
// _Hangman class will have mutable objects, interacted with by the user
// Described in documentation: https://flutter.dev/docs/development/ui/interactive
class Hangman extends StatefulWidget {
  const Hangman({Key? key}) : super(key: key);
  @override
  State<Hangman> createState() => _Hangman();
}

class _Hangman extends State<Hangman>{

  String _correctWord = "-";
  List<String> _correct = [];
  List<String> _incorrect = [];
  final int wrongLimit = 9;
  List<String> alphabet = [];
  bool _winState = false;
  bool _loseState = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      // your method where use the context
      // Example navigate:
      choose_correctWord(context);
    });
  }

  void restart() {
    _correct = [];
    _incorrect = [];
    choose_correctWord(context);
    _winState = false;
    _loseState = false;
  }

  void choose_correctWord(BuildContext context) {
    String potential = AppLocalizations.of(context)!.wordList;
    //Split method of string, doc: https://api.flutter.dev/flutter/dart-core/String/split.html
    List<String> potentialList = potential.split(", ");
    setState(() {
      _correctWord = potentialList[Random().nextInt(potentialList.length)];
    });
  }

  void guessLetter(BuildContext context, String letter) {
    if (_correctWord.toLowerCase().contains(letter.toLowerCase())) {
      setState(() {
        _correct.add(letter);
      });
    } else {
      setState(() {
        _incorrect.add(letter);
      });
    }
  }

  List<Widget> _buildButtonsFromAlphabet() {
    //List<String>alphabet = AppLocalizations.of(context)!.alphabet.split('');
    List<ElevatedButton> buttons = [];
    for (var char in alphabet){
      if (!_incorrect.contains(char) && !_correct.contains(char) && !_winState && !_loseState) {
        buttons.add(ElevatedButton(
            onPressed: () => guessLetter(context, char),
            child: Text(char)
        ));
      } else {
        buttons.add(ElevatedButton(
            onPressed: null,
            child: Text(char)
        ));
      }
    }
    return buttons;
  }

  List<String> updateGuessedState() {
    List<String> guessedWordsList = _correctWord.split('');
    return guessedWordsList.map((e) => _correct.contains(e.toLowerCase()) ? e : " _ ").toList();
  }


  String userFeedback(String _guessed){
    if (_winState) return AppLocalizations.of(context)!.winMessage + " " + _correctWord;
    else if (_loseState) return AppLocalizations.of(context)!.loseMessage + " " + _correctWord;
    else return _guessed;
  }

  @override
  Widget build(BuildContext context) {
    const paddingSize = 20.0;
    const TextStyle bodyStyle = TextStyle(fontSize: 15, color: Colors.black);
    List<String> _guessingState = updateGuessedState();
    alphabet = AppLocalizations.of(context)!.alphabet.split('');
    if (_guessingState.join() == _correctWord) _winState = true;
    if (_incorrect.length >= wrongLimit) _loseState = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.hangmanGame),
        //title: Text(_incorrect.length.toString() + " - " + wrongLimit.toString()),
      ),
      body: Center(

        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(paddingSize),
                child: Text(
                    userFeedback(_guessingState.join()),
                    style: bodyStyle
                )
            ),
            Padding(
                padding: EdgeInsets.all(paddingSize),
                //https://flutter.dev/docs/release/breaking-changes/buttons
                child: Image(
                  image: AssetImage('assets/images/hm${_incorrect.length+1}.png'),
                  height: 200
                ),
            ),
            Padding(
                padding: const EdgeInsets.all(5),
                //https://flutter.dev/docs/release/breaking-changes/buttons
                child: Column(
                  children: <Widget>[
                    Wrap(
                      children: _buildButtonsFromAlphabet()
                    )
                  ],

              )
            ),
            Padding(
                padding: const EdgeInsets.all(1),
                //https://flutter.dev/docs/release/breaking-changes/buttons
                child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered))
                            return Colors.blue.withOpacity(0.04);
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed))
                            return Colors.blue.withOpacity(0.12);
                          return null; // Defer to the widget's default.
                        },
                      ),
                    ),
                    onPressed: () { restart(); },
                    child: Text(AppLocalizations.of(context)!.restart)
                )
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}