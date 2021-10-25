import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Instructions extends StatelessWidget {
  const Instructions({Key? key}) : super(key: key);

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
                    AppLocalizations.of(context)!.gamePlay,
                    style: bodyStyle
                )
            ),
            Padding(
                padding: const EdgeInsets.all(paddingSize),
                child: Text(
                    AppLocalizations.of(context)!.languageInfo,
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
                    onPressed: () { Navigator.pushNamed(context, '/hangman'); },
                    child: Text(AppLocalizations.of(context)!.startGame)
                )
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}