import 'package:flutter/material.dart';
import '../../logic/game_logic.dart';
import 'game_tile.dart';


class GameFieldController {
  late void Function() runGame;
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

  void runGame() {
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
    widget.controller.runGame = runGame;
    widget.controller.clearField = clearField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tilesList = _game.getTilesList();
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

