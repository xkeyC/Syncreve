/// filePath : ""
/// savePath : ""
/// fileName : ""

class AppFileSavePathData {
  AppFileSavePathData({
      this.fileSavedFullPath,
      this.savePath, 
      this.fileName,});

  AppFileSavePathData.fromJson(dynamic json) {
    fileSavedFullPath = json['filePath'];
    savePath = json['savePath'];
    fileName = json['fileName'];
  }
  String? fileSavedFullPath;
  String? savePath;
  String? fileName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['filePath'] = fileSavedFullPath;
    map['savePath'] = savePath;
    map['fileName'] = fileName;
    return map;
  }

}