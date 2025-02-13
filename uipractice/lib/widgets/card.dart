import 'package:flutter/material.dart';
import 'package:uipractice/widgets/localBalanceNotation.dart';

class ForexIcon extends StatelessWidget {
  IconData? forexIcon;
  bool colorInverted;
  ForexIcon({super.key, required this.forexIcon, required this.colorInverted});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-20, 50),
      child: Transform.scale(
        scale: 5,
        child: Icon(forexIcon,
            color: colorInverted ? Colors.black : Colors.white, size: 50),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  String forexName;
  int balance;
  bool colorInverted;
  int order;
  late String strBalance;
  late String forexStringUnit;
  late Color cardColor;
  late Color fontColor;
  late IconData icon;
  // 멤버 변수는 생성한 동시에 대입되어야 함.

  CreditCard({
    required this.forexName,
    required this.balance,
    required this.colorInverted,
    required this.order,
  }) {
    var notation = LocalBalanceNotation.getInstance();
    strBalance = notation.convertLocalNotation(balance);
    var upperCase = forexName.toUpperCase();
    if (upperCase == "EURO") {
      forexStringUnit = "EUR";
      icon = Icons.euro_sharp;
    } else if (upperCase == "DOLLAR") {
      forexStringUnit = "USD";
      icon = Icons.attach_money;
    } else if (upperCase == "RUPEE") {
      forexStringUnit = "INR";
      icon = Icons.currency_rupee;
    }

    cardColor = colorInverted ? Color(0xffE3E3E3) : Color(0xff1B1D1F);
    fontColor = colorInverted ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, order * -30),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: (EdgeInsets.symmetric(vertical: 30, horizontal: 25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forexName,
                    style: TextStyle(
                        fontSize: 32,
                        color: fontColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        strBalance,
                        style: TextStyle(
                          fontSize: 28,
                          color: fontColor,
                        ),
                      ),
                      Text(
                        forexStringUnit,
                        style: TextStyle(
                          fontSize: 18,
                          color: fontColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ForexIcon(
                forexIcon: icon,
                colorInverted: colorInverted,
              )
            ],
          ),
        ),
      ),
    );
  }
}
