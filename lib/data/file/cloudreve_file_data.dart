class CloudreveFileData {
  CloudreveFileData({
    this.parent,
    this.objects,
    this.policy,
  });

  CloudreveFileData.fromJson(dynamic json) {
    parent = json['parent'];
    if (json['objects'] != null) {
      objects = [];
      json['objects'].forEach((v) {
        objects?.add(CloudreveFileObjectsData.fromJson(v));
      });
    }
    policy = json['policy'] != null
        ? CloudreveFilePolicyData.fromJson(json['policy'])
        : null;
  }

  String? parent;
  List<CloudreveFileObjectsData>? objects;
  CloudreveFilePolicyData? policy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['parent'] = parent;
    if (objects != null) {
      map['objects'] = objects?.map((v) => v.toJson()).toList();
    }
    if (policy != null) {
      map['policy'] = policy?.toJson();
    }
    return map;
  }
}

class CloudreveFilePolicyData {
  CloudreveFilePolicyData({
    this.id,
    this.name,
    this.type,
    this.maxSize,
    this.fileType,
  });

  CloudreveFilePolicyData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    maxSize = json['max_size'];
    if (json['file_type'] != null) {
      fileType = [];
      json['file_type'].forEach((v) {
        fileType?.add(v);
      });
    }
  }

  String? id;
  String? name;
  String? type;
  num? maxSize;
  List<dynamic>? fileType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['max_size'] = maxSize;
    if (fileType != null) {
      map['file_type'] = fileType?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CloudreveFileObjectsData {
  CloudreveFileObjectsData({
    this.id,
    this.name,
    this.path,
    this.pic,
    this.size,
    this.type,
    this.date,
    this.createDate,
    this.sourceEnabled,
  });

  CloudreveFileObjectsData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    path = json['path'];
    pic = json['pic'];
    size = json['size'];
    type = json['type'];
    date = json['date'];
    createDate = json['create_date'];
    sourceEnabled = json['source_enabled'];
  }

  String? id;
  String? name;
  String? path;
  String? pic;
  num? size;
  String? type;
  String? date;
  String? createDate;
  bool? sourceEnabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['path'] = path;
    map['pic'] = pic;
    map['size'] = size;
    map['type'] = type;
    map['date'] = date;
    map['create_date'] = createDate;
    map['source_enabled'] = sourceEnabled;
    return map;
  }
}
