import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uipractice/widgets/balance.dart';
import './widgets/button.dart';
import './widgets/userInfo.dart';
import './widgets/card.dart';

void main() {
  runApp(UIPractice());
}

class UIPractice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                UserInfo(name: "leFrog"),
                // UserInfo

                SizedBox(height: 80),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Balance(balance: 4294967295),
                    // Balance

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Button(
                          title: "Transfer",
                          color: Color(0xfff2b33a),
                        ),
                        Button(
                          title: "Request",
                          color: Color(0xff1f2123),
                          buttonColor: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Wallets",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text("View All",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(0xff, 0xff, 0xff, 0.8),
                            ))
                      ],
                    ),
                    SizedBox(height: 30),
                    CreditCard(
                      forexName: "Euro",
                      balance: 6428,
                      colorInverted: false,
                      order: 0,
                    ),
                    CreditCard(
                        forexName: "Dollar",
                        balance: 55622,
                        colorInverted: true,
                        order: 1),
                    CreditCard(
                        forexName: "Rupee",
                        balance: 28981,
                        colorInverted: false,
                        order: 2),
                    // CreditCard
                  ],
                )
              ],
            ), // Buttons
          ),
        ),
      ),
    );
  }
}
