import 'dart:convert';

import 'package:crypto/crypto.dart';

class StringUtil {
  static String getSha1(String str) {
    return sha1.convert(utf8.encode(str)).toString();
  }

  static String getTimeDateString(String time) {
    final t = DateTime.parse(time);
    return "${t.year.toString()}-${t.month.toString().padLeft(2, '0')}-${t.day.toString().padLeft(2, '0')}  ${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}:${t.second.toString().padLeft(2, '0')}";
  }
}
