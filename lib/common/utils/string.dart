import 'dart:convert';

import 'package:crypto/crypto.dart';

class StringUtil {
  static String getSha1(String str) {
    return sha1.convert(utf8.encode(str)).toString();
  }
}
