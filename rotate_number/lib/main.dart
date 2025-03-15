import 'package:flutter/material.dart';
import 'rotate_number.dart';

void main() {
  runApp(TestScreen());
}

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: RotateNumber(
              number: 4294967295,
              animationDuration: 200,
              style: TextStyle(color: Colors.amber, fontSize: 45)),
        ),
      ),
    );
  }
}
