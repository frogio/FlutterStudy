import 'package:flutter/material.dart';
import 'dart:math';
import 'Bat.dart';

class Ball extends StatefulWidget {
  final GlobalKey<BallState> ballKey;
  final GlobalKey<BatState> batKey;
  final VoidCallback incrementScore;
  final Function(BuildContext) gameOver;
  double devWidth;
  double devHeight;

  Ball({
    super.key,
    required this.ballKey,
    required this.batKey,
    required this.devWidth,
    required this.devHeight,
    required this.incrementScore,
    required this.gameOver,
  });

  @override
  State<Ball> createState() => BallState();

  void update() {
    ballKey.currentState?.update();
  }
}

class BallState extends State<Ball> {
  static const double diameter = 50;
  double x = 50;
  double y = 10;
  double theta = 0.25;
  double velocity = 5.0;
  Random random = Random();

  void update() {
    setState(() {
      double dx = velocity * cos(2 * pi * theta);
      double dy = velocity * sin(2 * pi * theta);

      x += dx;
      y += dy;

      // print(widget.bat.batKey.currentState);

      final batState = widget.batKey.currentState;

      double batLeft = batState!.x;
      double batTop = widget.devHeight - batState!.height;
      if (x < 0 || x > widget.devWidth - diameter) theta = 1 - theta + 0.5;
      if (y < 0) theta = 1 - theta;
      // y축 충돌은 축이 뒤집히므로 0.5를 더하지 않는다. (180도 회전하므로)
      if (batLeft - diameter <= x &&
          x <= batLeft + batState.width + diameter &&
          batTop < y + diameter) {
        theta += 0.5 + (random.nextDouble() - 0.5) / 2;
        theta -= theta.floor();
        widget.incrementScore();
      } // 막대기에 부딪힐 경우
      // 바닥으로 완전히 떨어질 경우
    });
  }

  void initGame() {
    setState(() {
      x = 50;
      y = 10;
      theta = 0.25;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (y > widget.devHeight) widget.gameOver(context);

    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }
}
