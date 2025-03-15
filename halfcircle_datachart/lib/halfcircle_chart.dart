import 'package:flutter/material.dart';
import 'dart:math';

class HalfCircleChartPainter extends CustomPainter {
  final List<double> values; // Data values (percentages)
  final List<Color> colors; // Colors for each segment
  final double strokeWidth; // Thickness of the arcs

  HalfCircleChartPainter({
    required this.values,
    required this.colors,
    this.strokeWidth = 20,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = strokeWidth;

    print("size width, height : ${size.width}, ${size.height}");

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height);
    double startAngle = pi;
    // 왼쪽 지점 부터 시작하여 시계방향으로 돌아감.

    double total = values.fold(0, (sum, value) => sum + value);
    // 데이터의 합, 0부터 시작하여 List 원소의 합을 구한다.

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = pi * (values[i] / total);
      // pi를 정규화 한다.

      paint.color = colors[i];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        // startAngle 부터 sweepAngle까지의 원호를 그린다.
        false, // Use stroke style
        paint,
      );

      startAngle += sweepAngle;
      // 기준 라디안을 옮긴다.
    }
  }

  @override
  bool shouldRepaint(HalfCircleChartPainter oldDelegate) => true;
}

class HalfCircleChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
          200, 100), // Width x Height (Half of the width for the half-circle)
      painter: HalfCircleChartPainter(
        values: [
          40,
          30,
          30
        ], // Data values (sum should be 100 for percentage-based)
        colors: [Colors.blue, Colors.red, Colors.green],
        strokeWidth: 100,
      ),
    );
  }
}
