import 'dart:async';
import 'package:flutter/material.dart';
import 'game_tiles/custom_button_start.dart';
import 'game_tiles/game_field.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.title});

  final String title;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late final GameFieldController gameController;

  late CustomButtonStart start;
  late TextButton step;
  late TextButton clear;

  late Timer _timer;

  void _startTimer() {
    const duration = Duration(milliseconds: 50);
    _timer = Timer.periodic(duration, (Timer timer) {
      gameController.runGame();
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  final ButtonStyle _raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.blue, backgroundColor: Colors.white,
    minimumSize: const Size(64, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Colors.blue, width: 2),
    ),
  );

  @override
  initState() {
    gameController = GameFieldController();

    super.initState();
    start = CustomButtonStart(
      startTimer: _startTimer,
      stopTimer: _stopTimer,
    );
    step = TextButton(
      style: _raisedButtonStyle,
      onPressed: () {
        gameController.runGame();
      },
      child: const Text('Step'),
    );
    clear = TextButton(
      style: _raisedButtonStyle,
      onPressed: () {
        gameController.clearField();
      },
      child: const Text('Clear'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return portraitMode();
            } else {
              return landscapeMode();
            }
          }),
    );
  }

  Center portraitMode() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                start,
                const SizedBox(width: 16),
                step,
                const SizedBox(width: 16),
                clear
              ]
          ),
          const SizedBox(
              height: 10
          ),
          GameField(controller: gameController)
          //GameField()
        ]
      )
    );
  }

  Center landscapeMode() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GameField(controller: gameController),
          const SizedBox(
              width: 16
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                start,
                const SizedBox(height: 24),
                step,
                const SizedBox(height: 24),
                clear
              ]
          )
        ]
    ));
  }
}