import 'package:flutter/material.dart';
import 'package:world_the_game/logic/game_logic.dart';


class GameTile extends StatelessWidget {

  final Function rebuild;
  final Tile tile;
  final GameWorld game;
  late final Color color;

  GameTile(this.rebuild, this.tile, this.game, {super.key}) {
    if(tile.alive == 1) {
      color = Colors.blue;
    } else {
      color = Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
        side: const BorderSide(color: Colors.black12, width: 1),
      ),
      color:  color,
      child: InkWell(
        splashColor: Colors.pink,
        onTap: () {
          if(tile.alive == 1) {
            rebuild(() {
              game.setDeadOne(tile.x, tile.y);
            });
          } else {
            rebuild(() {
              game.setAliveOne(tile.x, tile.y);
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