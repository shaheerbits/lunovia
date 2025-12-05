import 'package:flutter/material.dart';
import 'package:lunovia/pages/home_page.dart';
import 'package:lunovia/providers/player_provider.dart';
import 'package:lunovia/providers/songs_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (context) => PlayerProvider()),
      ChangeNotifierProvider(create: (context) => SongsProvider()),
    ],
    child: Lunovia(),
  ));
}

class Lunovia extends StatelessWidget {
  const Lunovia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(
            fontFamily: 'Plus Jakarta Sans',
            bodyColor: Color.fromRGBO(227, 227, 227, 1),
            displayColor: Color.fromRGBO(227, 227, 227, 1),
          )
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage()
    );
  }
}
