import 'package:flutter/material.dart';

void main() {
  runApp(Counter());
}

class Counter extends StatefulWidget {
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counter = 0;

  void Increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Click Count",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                "$counter",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              IconButton(
                icon: Icon(Icons.plus_one, size: 50),
                onPressed: Increment,
              ),

              // Material(
              //   color: Colors.transparent,
              //   child: InkWell(
              //     onTap: Increment,
              //     child: Transform.translate(
              //       offset: Offset(100, 300),
              //       child: Container(
              //         decoration: BoxDecoration(
              //           color: Colors.black,
              //         ),
              //         width: 50,
              //         height: 50,
              //       ),
              //     ),
              //   ),
              // ),
              // Transform(
              // transform: Matrix4.identity()
              // ..translate(10.0, 20.0), // Example rotation
              // alignment: Alignment.center,
              // child:
              // Container(
              //   decoration: BoxDecoration(color: Colors.blueGrey),
              //   width: 100,
              //   height: 100,
              //   child: Positioned.fill(
              //     child: GestureDetector(
              //       onTap: () {
              //         print('Button Pressed');
              //       },
              //     ),
              //   ),
              // ),
              // Hit area overlay
              // )
            ],
          ),
        ),
      ),
    );
  }
}
