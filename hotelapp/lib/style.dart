import 'package:flutter/material.dart';

class Responsive {
  /* Chia màn hình theo tỷ lệ phần trăm
    height: Responsive.height(50, context) => 50% chiều dọc
    width: Responsive.width(100, context) => 100% chiều ngang
  */
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

String toMoney(double money) {
  String rs = "";
  String moneyString = money.round().toString();
  int condition = moneyString.length;
  List<String> dv = [];
  while (condition > 0) {
    try {
      String temp = moneyString.substring(condition - 3);
      dv.add(temp);
      moneyString = moneyString.substring(0, condition - 3);
      condition = moneyString.length;
    } catch (e) {
      dv.add(moneyString);
      break;
    }
  }
  for (int i = dv.length - 1; i >= 0; i--) {
    rs += dv[i];
    rs += i > 0 ? '.' : '';
  }
  return rs.trim();
}
