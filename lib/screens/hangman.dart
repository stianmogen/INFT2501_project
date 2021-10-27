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

  String _correctWord = "";
  List<String> _correct = [];
  List<String> _incorrect = [];
  final int wrongLimit = 10;
  List<String> alphabet = [];

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
  }

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
      if (!_incorrect.contains(char) && !_correct.contains(char)) {
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

  //void initState() {
  //
  //}

  @override
  Widget build(BuildContext context) {
    const paddingSize = 20.0;
    const TextStyle bodyStyle = TextStyle(fontSize: 15, color: Colors.black);
    alphabet = AppLocalizations.of(context)!.alphabet.split('');
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
                    _correctWord + " " + (_incorrect).toString(),
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
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}