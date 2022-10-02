import 'dart:async';
import 'package:flutter/material.dart';
import 'package:world_the_game/logic/game_logic.dart';
import 'game_tiles/custom_button_start.dart';
import 'game_tiles/game_field.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final int _width = 30;
  final int _height = 30;
  late final GameWorld game = GameWorld(_width, _height);
  late final GameController gameController = GameController();
  late final GameField gameField = GameField(game: game, gameController: gameController);

  late final CustomButtonStart start;
  late final GameStateTransfer gameState = GameStateTransfer();
  late TextButton step;
  late TextButton clear;

  late Timer _timer;

  void startTimer() {
    const duration = Duration(milliseconds: 300);
    _timer = Timer.periodic(duration, (Timer timer) {
      gameController.updateField(() {
        game.run();
      });
    });
  }

  void stopTimer() {
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
    super.initState();

    start = CustomButtonStart(
      start: startTimer,
      stop: stopTimer,
      gameState: gameState,
    );

    step = TextButton(
      style: _raisedButtonStyle,
      onPressed: () {
        gameController.updateField(() {
          game.run();
        });
      },
      child: const Text('Step'),
    );

    clear = TextButton(
      style: _raisedButtonStyle,
      onPressed: () {
        gameController.updateField(() {
          game.clearField();
        });
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
          gameField
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
          gameField,
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