import 'package:flutter/material.dart';
import 'pages/game_page.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'World',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

