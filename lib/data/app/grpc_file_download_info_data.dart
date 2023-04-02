/// infoMap : {"dd882ce4-bfd8-4cee-a6e5-287a23a31ed2":{"ID":"dd882ce4-bfd8-4cee-a6e5-287a23a31ed2","URL":"https://pan.xkeyc.com/api/v3/file/download/qtrgtys7qH4JVJ7a?sign=SUIG3FrLzqPAP0QHKFeuYBTkjvxpcjKbon5RGquF0tY%3D%3A1680419366","savePath":"/data/user/0/com.xkeyc.apps.syncreve.syncreve/cache/temp_file/o70SX/","fileName":"初音ミク MusikM - 鹅饿饿鹅.flac","cookie":"cloudreve-session=MTY4MDQxNjAzNHxOd3dBTkVRelYxWlJNMFpYV0VnMVF6TkVURnBUUlU1UlMwTkNWRFpRU0VwYVdsbE1NekpKVVZSVU5sZFlOMWcwUkZGU1dsZFJWMUU9fItLVTit8aIRfOxeKgqAudoWLixhfhVDhFy15QD2Qc2h","downLoadType":2,"status":1,"downloadedSize":8001528,"contentLength":37697072}}
/// queueLen : 1
/// workingLen : 1

class GrpcFileDownloadInfoData {
  GrpcFileDownloadInfoData({
    this.infoMap,
    this.queueLen,
    this.workingLen,
  });

  GrpcFileDownloadInfoData.fromJson(dynamic json) {
    infoMap = json['infoMap'];
    queueLen = json['queueLen'];
    workingLen = json['workingLen'];
  }

  Map<String, dynamic>? infoMap;
  num? queueLen;
  num? workingLen;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (infoMap != null) {
      map['infoMap'] = infoMap;
    }
    map['queueLen'] = queueLen;
    map['workingLen'] = workingLen;
    return map;
  }
}

class GrpcFileDownloadInfoItemData {
  GrpcFileDownloadInfoItemData(
      {this.id,
      this.url,
      this.savePath,
      this.fileName,
      this.cookie,
      this.downLoadType,
      this.status,
      this.downloadedSize,
      this.contentLength,
      this.errorInfo});

  GrpcFileDownloadInfoItemData.fromJson(dynamic json) {
    id = json['ID'];
    url = json['URL'];
    savePath = json['savePath'];
    fileName = json['fileName'];
    cookie = json['cookie'];
    downLoadType = json['downLoadType'];
    status = json['status'];
    downloadedSize = json['downloadedSize'];
    contentLength = json['contentLength'];
    errorInfo = json["errorInfo"];
  }

  String? id;
  String? url;
  String? savePath;
  String? fileName;
  String? cookie;
  String? errorInfo;
  num? downLoadType;
  num? status;
  num? downloadedSize;
  num? contentLength;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['URL'] = url;
    map['savePath'] = savePath;
    map['fileName'] = fileName;
    map['cookie'] = cookie;
    map['downLoadType'] = downLoadType;
    map['status'] = status;
    map['downloadedSize'] = downloadedSize;
    map['contentLength'] = contentLength;
    map["errorInfo"] = errorInfo;
    return map;
  }
}
