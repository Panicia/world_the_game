import 'package:flutter/material.dart';
import 'package:world_the_game/logic/game_logic.dart';


class GameTile extends StatefulWidget {

  final int x;
  final int y;
  final GameWorld game;

  const GameTile(this.x, this.y, this.game, {super.key});

  @override
  _GameTile createState() => _GameTile();
}

class _GameTile extends State<GameTile> {

  late Color myColor;

  @override
  Widget build(BuildContext context) {

    if(widget.game.isAlive(widget.x, widget.y) == 1) {
      myColor = Colors.blue;
    } else {
      myColor = Colors.white70;
    }

    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
        side: const BorderSide(color: Colors.black12, width: 1),
      ),
      color:  myColor,
      child: InkWell(
        splashColor: Colors.pink,
        onTap: () {
          if(widget.game.isAlive(widget.x, widget.y) == 0) {
            myColor = Colors.blue;
            setState(() {
              widget.game.setAliveOne(widget.x, widget.y);
            });
          } else {
            myColor = Colors.white70;
            setState(() {
              widget.game.setDeadOne(widget.x, widget.y);
            });
          }
        },
        child: Container(
          padding: const EdgeInsets.all(5.5),
        ),
      ),
    );
  }
}