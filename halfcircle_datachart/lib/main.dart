import 'package:flutter/material.dart';
//import './halfcircle_chart.dart';
import './myhalfcircle_chart.dart';

void main() {
  runApp(Chart());
}

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: HalfCircleChart(
            total: 100,
            value: 70,
            animationTime: 500,
          ),
        ),
      ),
    );
  }
}
