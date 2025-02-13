import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  @protected
  String title;
  Color color;
  Color? buttonColor = Color.fromARGB(0xff, 0x00, 0x00, 0x00);

  Button(
      {super.key, required this.title, required this.color, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(45)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, color: buttonColor),
        ),
      ),
    );
  }
}
