import 'dart:async';
import 'package:flutter/material.dart';
import '../../logic/game_logic.dart';
import 'game_tile.dart';


class GameFieldController {
  late void Function() startGame;
  late void Function() stopGame;
  late void Function() singleStep;
  late void Function() clearField;
}

class GameField extends StatefulWidget {
  const GameField({super.key, required this.controller});
  final GameFieldController controller;

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {

  final int _width = 30;
  final int _height = 30;

  late final GameWorld _game = GameWorld(_width, _height);

  late Timer _timer;

  void startTimer() {
    const duration = Duration(milliseconds: 300);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        _game.run();
      });
    });
  }

  void startGame() {
    startTimer();
  }

  void stopGame() {
    _timer.cancel();
  }

  void singleStep() {
    setState(() {
      _game.run();
    });
  }

  void clearField() {
    setState(() {
      _game.clearField();
    });
  }

  @override
  void initState() {
    widget.controller.startGame = startGame;
    widget.controller.stopGame = stopGame;
    widget.controller.singleStep = singleStep;
    widget.controller.clearField = clearField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _game
          .getField()
          .asMap()
          .entries
          .map<Widget>((list) {
        int x = list.key;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: list.value
              .asMap()
              .entries
              .map<Widget>((state) {
            int y = state.key;
            return GameTile(setState, _game.getField()[x][y], _game);
          }).toList(),
        );
      }).toList(),
    );
  }
}

