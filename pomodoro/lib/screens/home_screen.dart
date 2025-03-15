import 'package:flutter/material.dart';
import 'package:pomodoro/main.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int POMODORO = 1500;
  int totalSecond = POMODORO;
  late Timer? timer;
  bool isStart = false;
  IconData icon = Icons.play_circle_outline;
  int totalPomodoros = 0;

  void onTick(Timer timer) {
    setState(() {
      if (totalSecond == 0) {
        totalPomodoros++;
        totalSecond = POMODORO;
        timer.cancel();
        isStart = false;
        icon = Icons.play_circle_outline;
        return;
      } else
        totalSecond--;
    });
  }

  void initTimer() {
    setState(() {
      icon = Icons.play_circle_outline;
      totalSecond = POMODORO;
      isStart = false;
      timer?.cancel();
    });
  }

  void onPressTimer() {
    if (isStart == false) {
      timer = Timer.periodic(Duration(seconds: 1), onTick);
      setState(() {
        icon = Icons.pause_circle_outline;
      });
      isStart = true;
    } else {
      timer?.cancel();
      setState(() {
        icon = Icons.play_circle_outline;
      });
      isStart = false;
    }
  }

  String convertSecToMin(int second) {
    var rowFormat = Duration(seconds: second).toString();
    return rowFormat.substring(2, rowFormat.indexOf("."));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Stack Container의 크기는 자식 요소중 가장 큰 값을 크기로 갖는다.
                  // 따라서 자식 중 Stack의 부모 영역을 모두 가지는 자식을 추가하면 Stack 크기를 확장할 수 있다.
                  Container(
                    width: double.infinity,
                  ),
                  Text(
                    convertSecToMin(totalSecond),
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 89,
                    ),
                  ),
                  Positioned(
                    top: 95,
                    left: 320,
                    child: IconButton(
                      icon: Icon(Icons.refresh),
                      iconSize: 45,
                      color: Theme.of(context).cardColor,
                      onPressed: initTimer,
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                icon: Icon(icon),
                iconSize: 120,
                color: Theme.of(context).cardColor,
                onPressed: onPressTimer,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pomodoros",
                        style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        "$totalPomodoros",
                        style: TextStyle(
                          fontSize: 90,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
