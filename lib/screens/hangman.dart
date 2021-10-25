import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Hangman extends StatelessWidget {
  const Hangman({Key? key}) : super(key: key);

  

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
                    AppLocalizations.of(context)!.hangmanTitle,
                    style: bodyStyle
                )
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}