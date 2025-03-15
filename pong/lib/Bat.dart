import 'package:flutter/material.dart';

class Bat extends StatefulWidget {
  double width;
  double height;

  Bat({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<Bat> createState() => BatState();
}

class BatState extends State<Bat> {
  late final double width;
  late final double height;
  double x = 0;

  @override
  void initState() {
    width = widget.width;
    height = widget.height;
    super.initState();
  }

  void moveBat(DragUpdateDetails update) {
    setState(() {
      x += update.delta.dx;
    });
  }

  void initGame() {
    setState(() {
      x = 0;
    });
  }

  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      bottom: 0,
      child: GestureDetector(
        onHorizontalDragUpdate: moveBat,
        child: Container(width: width, height: height, color: Colors.black),
      ),
    );
  }
}
