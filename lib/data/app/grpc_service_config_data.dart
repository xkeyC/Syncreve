/// port : 39399
/// working_dir : "/"
/// temp_dir : "/"
library;

class AppGrpcServiceConfigData {
  AppGrpcServiceConfigData({
    this.workingDir,
    this.tempDir,
  });

  AppGrpcServiceConfigData.fromJson(dynamic json) {
    workingDir = json['working_dir'];
    tempDir = json['temp_dir'];
  }

  int? port;
  String? workingDir;
  String? tempDir;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['working_dir'] = workingDir;
    map['temp_dir'] = tempDir;
    return map;
  }
}
