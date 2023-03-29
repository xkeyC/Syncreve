/// code : 0
/// data : null
/// msg : ""

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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['data'] = data;
    map['msg'] = msg;
    return map;
  }

  bool get isOK => code == 0;
}
