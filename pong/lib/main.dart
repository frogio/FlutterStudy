import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Bat.dart';
import 'Ball.dart';

void main() {
  runApp(Pong());
}

class Pong extends StatefulWidget {
  @override
  State<Pong> createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  final GlobalKey<BallState> _ballKey = GlobalKey<BallState>();
  final GlobalKey<BatState> _batKey = GlobalKey<BatState>();
  late Ball ball;
  late Bat bat;

  late Animation<double> animation;
  late AnimationController controller;
  bool isInit = false;
  int score = 0;
  late final double devWidth;
  late final double devHeight;

  void incrementScore() {
    setState(() {
      score++;
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      devWidth = MediaQuery.of(context).size.width;
      devHeight = MediaQuery.of(context).size.height;

      bat = Bat(
        key: _batKey,
        width: devWidth / 5,
        height: devHeight / 20,
      );
      ball = Ball(
        key: _ballKey,
        ballKey: _ballKey,
        batKey: _batKey,
        devWidth: devWidth,
        devHeight: devHeight,
        incrementScore: incrementScore,
        gameOver: gameOver,
      );
      isInit = true;
      setState(() {});
    });

    controller = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 0.0).animate(controller);
    animation.addListener(() {
      if (isInit) {
        ball.update();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void gameOver(BuildContext context) {
    // setState({});
    controller.stop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Game Over"),
                content: Container(
                  height: 70,
                  child: Column(children: [
                    Text("Your Best Score is $score"),
                    Text("Would you like Try Again?"),
                  ]),
                ),
                actions: [
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      setState(() {
                        _ballKey.currentState!.initGame();
                        _batKey.currentState!.initGame();
                        score = 0;
                      });

                      Navigator.of(context).pop();
                      controller.repeat();
                    },
                  ),
                  TextButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      SystemNavigator.pop();
                      // dispose();
                    },
                  )
                ]);
            // content:
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pong",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Stack(
          children: [
            isInit ? ball : Container(),
            isInit ? bat : Container(),
            Positioned(
              right: 10,
              top: 50,
              child: Text("Score : $score", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
