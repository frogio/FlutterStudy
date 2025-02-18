import 'package:flutter/material.dart';
import './screens//home_screen.dart';

void main() {
  runApp(PomodoroMain());
}

class PomodoroMain extends StatelessWidget {
  @override
  Widget build(BuildContext build) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE7626C),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
