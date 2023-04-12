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
    map['infoMap'] = infoMap;
    map['queueLen'] = queueLen;
    map['workingLen'] = workingLen;
    return map;
  }
}

class GrpcFileDownloadInfoItemData {
  GrpcFileDownloadInfoItemData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.savePath,
    this.fileName,
    this.fileID,
    this.workingUrl,
    this.instanceUrl,
    this.cookie,
    this.downLoadType,
    this.totalSize,
    this.status,
    this.errorInfo,
    this.downloadedSize,
  });

  GrpcFileDownloadInfoItemData.fromJson(dynamic json) {
    id = json['ID'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    savePath = json['savePath'];
    fileName = json['fileName'];
    fileID = json['fileID'];
    workingUrl = json['workingUrl'];
    instanceUrl = json['instanceUrl'];
    cookie = json['cookie'];
    downLoadType = json['downLoadType'];
    totalSize = json['totalSize'];
    status = json['status'];
    errorInfo = json['errorInfo'];
    downloadedSize = json['downloadedSize'];
  }

  String? id;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? savePath;
  String? fileName;
  String? fileID;
  String? workingUrl;
  String? instanceUrl;
  String? cookie;
  num? downLoadType;
  num? totalSize;
  int? status;
  String? errorInfo;
  num? downloadedSize;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['deletedAt'] = deletedAt;
    map['savePath'] = savePath;
    map['fileName'] = fileName;
    map['fileID'] = fileID;
    map['workingUrl'] = workingUrl;
    map['instanceUrl'] = instanceUrl;
    map['cookie'] = cookie;
    map['downLoadType'] = downLoadType;
    map['totalSize'] = totalSize;
    map['status'] = status;
    map['errorInfo'] = errorInfo;
    map['downloadedSize'] = downloadedSize;
    return map;
  }
}
