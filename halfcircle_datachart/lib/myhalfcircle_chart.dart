import 'package:flutter/material.dart';
import 'dart:math';

class HalfCircleChart extends StatelessWidget {
  late RotateNumber rotNumber;
  final double total;
  final int value;
  final int animationTime;

  HalfCircleChart(
      {required this.total, required this.value, required this.animationTime});

  @override
  Widget build(BuildContext context) {
    int tmp = value;
    int digit = 0;

    while (tmp > 0) {
      tmp ~/= 10;
      digit++;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyHalfCircleChart(
            total: total,
            value: value.toDouble(),
            animationTime: animationTime),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotateNumber(
              number: value,
              animationDuration: animationTime ~/ digit,
              style: TextStyle(
                fontSize: 50,
              ),
            ),
            Text(
              "%",
              style: TextStyle(
                fontSize: 50,
              ),
            )
          ],
        )
      ],
    );
  }
}

class MyHalfCircleChartPainter extends CustomPainter {
  final double total;
  final double values; // Data values (percentages)
  final double strokeWidth; // Thickness of the arcs

  MyHalfCircleChartPainter({
    required this.total,
    required this.values,
    this.strokeWidth = 100,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = strokeWidth;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height);
    double startAngle = pi;
    // 왼쪽 지점 부터 시작하여 시계방향으로 돌아감.

    final Paint shadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3)
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center + Offset(10, 10), radius: radius),
      startAngle,
      pi,
      // startAngle 부터 sweepAngle까지의 원호를 그린다.
      false, // Use stroke style
      shadowPaint,
    );

    paint.color = Colors.grey.shade400;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      pi,
      // startAngle 부터 sweepAngle까지의 원호를 그린다.
      false, // Use stroke style
      paint,
    );

    paint.color = Colors.amber;
    paint.strokeWidth += 1;

    double radian = pi * (values / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      radian,
      // startAngle 부터 sweepAngle까지의 원호를 그린다.
      false, // Use stroke style
      paint,
    );
  }

  @override
  bool shouldRepaint(MyHalfCircleChartPainter oldDelegate) => true;
}

class MyHalfCircleChart extends StatefulWidget {
  double total;
  double value;
  int animationTime;

  MyHalfCircleChart(
      {required this.total, required this.value, required this.animationTime});

  @override
  State<MyHalfCircleChart> createState() => _MyHalfCircleChartState();
}

class _MyHalfCircleChartState extends State<MyHalfCircleChart>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late int millisec;
  @override
  void initState() {
    millisec = widget.animationTime;

    controller = AnimationController(
      duration: Duration(milliseconds: millisec),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: widget.value).animate(controller);
    animation.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 100),
      painter: MyHalfCircleChartPainter(
        total: widget.total,
        values: animation.value,
      ),
    );
  }
}

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
