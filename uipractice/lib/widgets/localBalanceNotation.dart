import 'package:sprintf/sprintf.dart';

class LocalBalanceNotation {
  static LocalBalanceNotation notation =
      LocalBalanceNotation._privateConstructor();

  LocalBalanceNotation._privateConstructor();

  static LocalBalanceNotation getInstance() {
    return notation;
  }

  String convertLocalNotation(int balance) {
    String result = '';
    while (balance != 0) {
      int remain = balance % 1000;

      // 마지막 자리가 아닐 경우
      if (balance ~/ 1000 != 0)
        result = "${sprintf("%03i", [remain])} $result";
      else
        result = "$remain $result";
      balance ~/= 1000;
    }
    return result;
  }
}
