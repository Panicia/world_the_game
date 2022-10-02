import 'package:flutter/material.dart';
import '../../logic/game_logic.dart';
import 'game_tile.dart';

class GameController {
  late Function updateField;
}

class GameField extends StatefulWidget {
  const GameField({super.key, required this.game, required this.gameController});
  final GameWorld game;
  final GameController gameController;

  @override
  State<GameField> createState() => _GameFieldState();
}

class _GameFieldState extends State<GameField> {
  @override
  void initState() {
    widget.gameController.updateField = setState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widget.game
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
            return GameTile(setState, widget.game.getField()[x][y], widget.game);
          }).toList(),
        );
      }).toList(),
    );
  }
}

