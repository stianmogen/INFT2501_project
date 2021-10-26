import 'dart:math';

import 'package:flutter/material.dart';
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

  String _correctWord = "";
  List<String> _correct = [];
  List<String> _incorrect = [];
  int _wrongCounter = 0;
  final int wrongLimit = 9;
  List<ElevatedButton> buttons = [];

  void choose_correctWord(BuildContext context){
    String potential = AppLocalizations.of(context)!.wordList;
    //Split method of string, doc: https://api.flutter.dev/flutter/dart-core/String/split.html
    List<String> potentialList = potential.split(", ");
    setState(() {
      _correctWord = potentialList[Random().nextInt(potentialList.length)];
    });
  }

  void winState(BuildContext context) {

  }

  void guessLetter(BuildContext context, String letter) {
    if (_correctWord.toLowerCase().contains(letter.toLowerCase())) {
      setState(() {
        _incorrect.add(letter);
        _wrongCounter == _incorrect.length;
      });
      _correct.add(letter);
    } else {
      setState(() {
        _incorrect.add(letter);
        _wrongCounter == _incorrect.length;
      });
    }
  }

  List<Widget> _buildButtonsFromAlphabet() {
    List<String>alphabet = AppLocalizations.of(context)!.alphabet.split('');
    for (var char in alphabet){
      buttons.add(ElevatedButton(
          onPressed: () => guessLetter(context, char),
          child: Text(char)
      ));
    }
    return buttons;
  }

  //void initState() {
  //
  //}

  @override
  Widget build(BuildContext context) {
    const paddingSize = 20.0;
    const TextStyle bodyStyle = TextStyle(fontSize: 15, color: Colors.black);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      body: Center(

        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(paddingSize),
                child: Text(
                    AppLocalizations.of(context)!.hangmanGame,
                    style: bodyStyle
                )
            ),
            Padding(
                padding: const EdgeInsets.all(paddingSize),
                child: Text(
                    _correctWord,
                    style: bodyStyle
                )
            ),
            Padding(
                padding: const EdgeInsets.all(paddingSize),
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
                    onPressed: () { choose_correctWord(context); },
                    child: Text(AppLocalizations.of(context)!.alphabet)
                )
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
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}