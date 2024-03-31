/// code : 0
/// data : null
/// msg : ""
library;

class AppHttpResultData {
  AppHttpResultData({
    this.code,
    this.data,
    this.msg,
  });

  AppHttpResultData.fromJson(dynamic json) {
    code = json['code'];
    data = json['data'];
    msg = json['msg'];
  }

  num? code;
  dynamic data;
  String? msg;
  int? sourceStatusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['data'] = data;
    map['msg'] = msg;
    return map;
  }

  bool get isOK => code == 0;
}
