import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:inft_2501_project/screens/hangman.dart';
import 'package:inft_2501_project/screens/instructions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      initialRoute: '/',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        //Named routes for navigation, docs: https://flutter.dev/docs/cookbook/navigation/named-routes
      routes: {
        '/': (context) => const Instructions(),
        '/hangman': (context) => const Hangman()
      }
    );
  }
}