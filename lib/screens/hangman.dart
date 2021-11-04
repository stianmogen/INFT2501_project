import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/// Hangman is a stateful widget
///
/// _Hangman class will have mutable objects, interacted with by the user
/// Described in documentation: https://flutter.dev/docs/development/ui/interactive
class Hangman extends StatefulWidget {
  const Hangman({Key? key}) : super(key: key);
  @override
  State<Hangman> createState() => _Hangman();
}

///_Hangman class for game
class _Hangman extends State<Hangman>{

  String _correctWord = "-";
  List<String> _correct = [];
  List<String> _incorrect = [];
  final int wrongLimit = 9;
  List<String> alphabet = [];
  bool _winState = false;
  bool _loseState = false;

  ///Initializes state and chooses a correct word
  @override
  void initState() {
    super.initState();
    //PostFrameCallback for choosing correct word when initializing state
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      choose_correctWord(context);
    });
  }

  ///Restart method, sets the variables to correct state
  void restart() {
    _correct = [];
    _incorrect = [];
    //New word to be chosen at each restard
    choose_correctWord(context);
    _winState = false;
    _loseState = false;
  }

  ///Method to choose correct word
  ///
  /// Uses the AppLocalization of "Word list", to find the list of words for current language
  /// From these words, the appliation chooses one at random
  void choose_correctWord(BuildContext context) {
    String potential = AppLocalizations.of(context)!.wordList;
    //Split method of string, doc: https://api.flutter.dev/flutter/dart-core/String/split.html
    List<String> potentialList = potential.split(", ");
    setState(() {
      _correctWord = potentialList[Random().nextInt(potentialList.length)];
    });
  }

  ///Method to guess letter on the correct word
  ///
  /// Adds character to correct list if correct
  /// Adds character to incorrect list if incorrect
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

  ///Builds a list of elevated buttons to represent the alphabet
  ///
  ///Each time a character is chosen, the alphabet is regenerated with corresponding button disabled
  ///If correct word is guessed, or the max limit for guesses is reached, the entire alphabet is disabled
  List<Widget> _buildButtonsFromAlphabet() {
    //List<String>alphabet = AppLocalizations.of(context)!.alphabet.split('');
    List<ElevatedButton> buttons = [];
    for (var char in alphabet){
      if (!_incorrect.contains(char) && !_correct.contains(char) && !_winState && !_loseState) {
        buttons.add(ElevatedButton(
            onPressed: () => guessLetter(context, char),
            child: Text(char.toUpperCase())
        ));
      } else {
        buttons.add(ElevatedButton(
            onPressed: null,
            child: Text(char.toUpperCase())
        ));
      }
    }
    return buttons;
  }

  ///Shows AlertDialog with information given on systems language
  void helpDialog() {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.help,
          ),
          content: Text(
              AppLocalizations.of(context)!.gamePlay
          )
      );
    });
  }

  ///Help button method calls helpDialog method
  Widget helpButton(){
    //This particular style can be found in documentation:
    //https://flutter.dev/docs/release/breaking-changes/buttons
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.blue.withOpacity(0.04);
            }
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed)) {
              return Colors.blue.withOpacity(0.12);
            }
            return null; // Defer to the widget's default.
          },
        ),
      ),
      onPressed: () { helpDialog(); },
      child: Text(AppLocalizations.of(context)!.help)
    );
  }

  ///Restard button resets the state with restart method
  Widget restartButton(){
    return TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.blue.withOpacity(0.04);
              }
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return Colors.blue.withOpacity(0.12);
              }
              return null; // Defer to the widget's default.
            },
          ),
        ),
        onPressed: () { restart(); },
        child: Text(AppLocalizations.of(context)!.restart)
    );
  }

  ///Updates the guessed state
  ///
  /// Uses all correct letters guessed list, and maps to each corresponding letter in correct word
  /// If a letter from the correct word is guessed, it is registered and displayed to the user
  List<String> updateGuessedState() {
    List<String> guessedWordsList = _correctWord.split('');
    //maps so that if a correct letter is guessed, this letter is registered
    //if it is not guessed it is displayed as an underscore: " _ "
    return guessedWordsList.map((e) => _correct.contains(e.toLowerCase()) ? e : " _ ").toList();
  }


  ///Gives feedback to the user as to the current game state
  ///
  ///If we have won or lost, we give this feedback to the user
  ///If we are currently plating, the guessing state is displayed
  String userFeedback(String _guessed){
    //if won or lost, the correct word with the corresponding win/lose messge is returned
    if (_winState) return AppLocalizations.of(context)!.winMessage + " " + _correctWord;
    else if (_loseState) return AppLocalizations.of(context)!.loseMessage + " " + _correctWord;
    else return _guessed;
  }

  ///Builds the statefull widgets the user iteracts with
  @override
  Widget build(BuildContext context) {
    const TextStyle bodyStyle = TextStyle(fontSize: 15, color: Colors.black);
    List<String> _guessingState = updateGuessedState();
    alphabet = AppLocalizations.of(context)!.alphabet.split('');
    //Win state and loss state is decided by there given conditions
    if (_guessingState.join() == _correctWord) _winState = true;
    if (_incorrect.length >= wrongLimit) _loseState = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.hangmanGame),
      ),
      body: Center(

        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                    userFeedback(_guessingState.join()),
                    style: bodyStyle
                )
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: Image(
                  //guessing state image is decided by the amount of incorrect guessing
                  //image is fethced from assets folder
                  image: AssetImage('assets/images/hm${_incorrect.length+1}.png'),
                  height: 200
                ),
            ),
            Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Wrap(
                      //wraps the list of buttons returned from build alphabet method
                      children: _buildButtonsFromAlphabet()
                    )
                  ],

              )
            ),
            Padding(
                padding: const EdgeInsets.all(3),
                child: Wrap(
                  children: <Widget>[
                    //restart- and helpButton wrapped as children at the bottom of the app
                    restartButton(), helpButton()
                  ]
                )
            ),
          ],
        ),
      ),
    );
  }
}