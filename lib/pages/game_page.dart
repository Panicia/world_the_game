import 'dart:async';
import 'package:flutter/material.dart';
import 'package:world_the_game/logic/game_logic.dart';
import 'game_tiles/game_tile.dart';


class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.title});

  final String title;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  late Timer _timer;

  final int width = 30;
  final int height = 30;

  late GameWorld game = GameWorld(width, height);

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.blue, backgroundColor: Colors.white,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Colors.blue, width: 2),
    ),
  );

  void startTimer() {
    const duration = Duration(milliseconds: 200);
    _timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        game.run();
      });
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    startTimer();
                  },
                  child: const Text('Start'),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    stopTimer();
                  },
                  child: const Text('Stop'),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    setState(() {
                      game.clearField();
                    });
                  },
                  child: const Text('Clear'),
                ),]
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: game.getField().asMap().entries.map<Widget>((list) {
              int x = list.key;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: list.value.asMap().entries.map<Widget>((state) {
                  int y = state.key;
                  return GameTile(x, y, game);
                }).toList(),
              );
            }).toList(),
          ),]
        ),
      ),
    );
  }
}