import 'package:flutter/material.dart';
import 'game_tiles/custom_button_start.dart';
import 'game_tiles/game_field.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late final GameFieldController gameController;
  late final GameField gameField = GameField(controller: gameController);

  late final CustomButtonStart start;
  late TextButton step;
  late TextButton clear;

  final ButtonStyle _raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.blue, backgroundColor: Colors.white,
    minimumSize: const Size(64, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Colors.blue, width: 2),
    ),
  );

  void _startGame() {
    gameController.startGame();
  }

  void _stopGame() {
    gameController.stopGame();
  }

  @override
  initState() {
    super.initState();
    gameController = GameFieldController();

    start = CustomButtonStart(
      start: _startGame,
      stop: _stopGame,
    );
    step = TextButton(
      style: _raisedButtonStyle,
      onPressed: () {
        gameController.singleStep();
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