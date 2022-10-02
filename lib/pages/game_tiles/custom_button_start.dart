import 'package:flutter/material.dart';

class CustomButtonStart extends StatefulWidget {
  const CustomButtonStart({super.key, required this.start, required this.stop});

  final Function start;
  final Function stop;

  @override
  State<CustomButtonStart> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButtonStart> {

  bool pressed = false;
  String text = 'Start';
  Color firstColor = Colors.blue;
  Color secondColor = Colors.white;
  double borderWidth = 2;

  void pressButton() {
    if(!pressed){
      widget.start();
      setStopButton();
    } else {
      widget.stop();
      setStartButton();
    }
  }

  void setStopButton() {
    setState(() {
      text = 'Stop';
      firstColor = Colors.white;
      secondColor = Colors.pink;
      borderWidth = 0;
      pressed = true;
    });
  }

  void setStartButton() {
    setState(() {
      text = 'Start';
      firstColor = Colors.blue;
      secondColor = Colors.white;
      borderWidth = 2;
      pressed = false;
    });
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