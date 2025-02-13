// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:uipractice/widgets/localBalanceNotation.dart';

class Balance extends StatelessWidget {
  late String strBalance;
  int balance;

  Balance({super.key, required this.balance}) {
    var notation = LocalBalanceNotation.getInstance();
    strBalance = "\$${notation.convertLocalNotation(balance)}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Total Balance",
        style: TextStyle(
          color: Color.fromRGBO(0xff, 0xff, 0xff, 0.8),
          fontSize: 15,
        ),
      ),
      SizedBox(height: 10),
      Text(
        strBalance,
        style: TextStyle(
            fontSize: 40,
            color: Color(0xffffffff),
            fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 20)
    ]);
  }
}
