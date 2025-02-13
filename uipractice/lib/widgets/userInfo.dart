import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  String name;

  UserInfo({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Hey, $name",
              style: TextStyle(
                  fontSize: 28,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Welcome back",
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(0xff, 0xff, 0xff, 0.8),
              ),
            ),
          ], // Column Children
        ),
      ],
    );
  }
}
