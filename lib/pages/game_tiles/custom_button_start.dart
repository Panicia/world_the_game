import 'package:flutter/material.dart';

class GameStateTransfer {
  bool started = false;
}

class CustomButtonStart extends StatefulWidget {
  const CustomButtonStart({super.key, required this.start, required this.stop, required this.gameState});
  final Function start;
  final Function stop;
  final GameStateTransfer gameState;

  @override
  State<CustomButtonStart> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButtonStart> {

  late String text;
  late Color firstColor;
  late Color secondColor;
  late double borderWidth;

  void pressButton() {
    if(!widget.gameState.started){
      widget.start();
      setStopButton();
      widget.gameState.started = true;
    } else {
      widget.stop();
      setStartButton();
      widget.gameState.started = false;
    }
  }

  void setStopButton() {
    setState(() {
      text = 'Stop';
      firstColor = Colors.white;
      secondColor = Colors.pink;
      borderWidth = 0;
    });
  }

  void setStartButton() {
    setState(() {
      text = 'Start';
      firstColor = Colors.blue;
      secondColor = Colors.white;
      borderWidth = 2;
    });
  }

  @override
  void initState() {
    if(!widget.gameState.started) {
      setStartButton();
    } else {
      setStopButton();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: firstColor, backgroundColor: secondColor,
      minimumSize: const Size(64, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        side: BorderSide(color: firstColor, width: borderWidth),
      ),
    );
    return TextButton(
      style: raisedButtonStyle,
      onPressed: () {
        pressButton();
      },
      child: Text(text),
    );
  }

}