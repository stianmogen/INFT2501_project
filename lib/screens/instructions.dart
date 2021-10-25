import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Instructions extends StatelessWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const paddingSize = 20.0;
    const TextStyle bodyStyle = TextStyle(fontSize: 14, color: Colors.black);
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
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}