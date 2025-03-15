import 'package:flutter/material.dart';

class RotateNumber extends StatefulWidget {
  final int number;
  final int animationDuration;
  final TextStyle? style;

  const RotateNumber(
      {super.key,
      required this.number,
      required this.animationDuration,
      TextStyle? style})
      : this.style = style;

  @override
  State<RotateNumber> createState() => _RotateNumberState();
}

class _RotateNumberState extends State<RotateNumber>
    with SingleTickerProviderStateMixin {
  late final int number;
  late final int digitCount;
  late final int animationDuration;
  String numStr = "";
  String animationOutput = "";

  late AnimationController controller;
  late Animation<double> animation;

  late int animationNumber;
  late int increment = 0;
  late int curDigit = 1;
  late int curNumber = 0;

  void _getDigitCount() {
    int num = number;
    int digitCount = 0;

    while (num > 0) {
      num ~/= 10;
      digitCount++;
    }

    this.digitCount = digitCount;
    animationOutput = " " * digitCount;
  }

  String _replaceCharAt(String input, int index, String newChar) {
    if (index < 0 || index >= input.length) {
      throw ArgumentError("Index out of range");
    }
    return input.substring(0, index) + newChar + input.substring(index + 1);
  }

  @override
  void initState() {
    number = widget.number;
    animationNumber = widget.number;
    animationDuration = widget.animationDuration;
    numStr = number.toString();

    _getDigitCount();
    curNumber = int.parse(numStr[numStr.length - curDigit]);
    controller = AnimationController(
        duration: Duration(milliseconds: animationDuration), vsync: this);

    animation = Tween(begin: 0.0, end: 10.0).animate(controller);
    animation.addListener(() {
      setState(() {
        // animation.value에서 중복된 값이 발생하므로, increment보다 커질 때 증가시킴
        int value = animation.value.floor();

        if (increment <= value) {
          animationNumber = (curNumber + increment) % 10;
          animationOutput = _replaceCharAt(animationOutput,
              numStr.length - curDigit, animationNumber.toString());
          increment++;
        }
      });
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed && curDigit < digitCount) {
        // 애니메이션이 끝난 숫자를 확실하게 지정한다.
        animationOutput = _replaceCharAt(animationOutput,
            numStr.length - curDigit, numStr[numStr.length - curDigit]);

        increment = 0;
        curDigit++;
        curNumber = int.parse(numStr[numStr.length - curDigit]);
        controller.reset();
        controller.forward();
      }
      // 맨 마지막 숫자를 확실하게 지정한다.
      else if (curDigit >= digitCount) {
        animationOutput = _replaceCharAt(animationOutput,
            numStr.length - curDigit, numStr[numStr.length - curDigit]);
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      animationOutput,
      style: widget.style,
    );
  }
}
