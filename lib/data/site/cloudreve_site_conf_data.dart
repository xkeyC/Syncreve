class CloudreveSiteConfData {
  CloudreveSiteConfData({
    this.title,
    this.loginCaptcha,
    this.regCaptcha,
    this.forgetCaptcha,
    this.emailActive,
    this.themes,
    this.defaultTheme,
    this.homeViewMethod,
    this.shareViewMethod,
    this.authn,
    this.user,
  });

  CloudreveSiteConfData.fromJson(dynamic json) {
    title = json['title'];
    loginCaptcha = json['loginCaptcha'];
    regCaptcha = json['regCaptcha'];
    forgetCaptcha = json['forgetCaptcha'];
    emailActive = json['emailActive'];
    themes = json['themes'];
    defaultTheme = json['defaultTheme'];
    homeViewMethod = json['home_view_method'];
    shareViewMethod = json['share_view_method'];
    authn = json['authn'];
    user = json['user'] != null
        ? CloudreveSiteConfUserData.fromJson(json['user'])
        : null;
  }

  String? title;
  bool? loginCaptcha;
  bool? regCaptcha;
  bool? forgetCaptcha;
  bool? emailActive;
  String? themes;
  String? defaultTheme;
  String? homeViewMethod;
  String? shareViewMethod;
  bool? authn;
  CloudreveSiteConfUserData? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['loginCaptcha'] = loginCaptcha;
    map['regCaptcha'] = regCaptcha;
    map['forgetCaptcha'] = forgetCaptcha;
    map['emailActive'] = emailActive;
    map['themes'] = themes;
    map['defaultTheme'] = defaultTheme;
    map['home_view_method'] = homeViewMethod;
    map['share_view_method'] = shareViewMethod;
    map['authn'] = authn;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

class CloudreveSiteConfUserData {
  CloudreveSiteConfUserData({
    this.id,
    this.userName,
    this.nickname,
    this.status,
    this.avatar,
    this.createdAt,
    this.preferredTheme,
    this.anonymous,
    this.group,
    this.tags,
  });

  CloudreveSiteConfUserData.fromJson(dynamic json) {
    id = json['id'];
    userName = json['user_name'];
    nickname = json['nickname'];
    status = json['status'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    preferredTheme = json['preferred_theme'];
    anonymous = json['anonymous'];
    group = json['group'] != null
        ? CloudreveSiteConfGroupData.fromJson(json['group'])
        : null;
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((v) {
        tags?.add(v);
      });
    }
  }

  String? id;
  String? userName;
  String? nickname;
  num? status;
  String? avatar;
  String? createdAt;
  String? preferredTheme;
  bool? anonymous;
  CloudreveSiteConfGroupData? group;
  List<dynamic>? tags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_name'] = userName;
    map['nickname'] = nickname;
    map['status'] = status;
    map['avatar'] = avatar;
    map['created_at'] = createdAt;
    map['preferred_theme'] = preferredTheme;
    map['anonymous'] = anonymous;
    if (group != null) {
      map['group'] = group?.toJson();
    }
    if (tags != null) {
      map['tags'] = tags?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CloudreveSiteConfGroupData {
  CloudreveSiteConfGroupData({
    this.id,
    this.name,
    this.allowShare,
    this.allowRemoteDownload,
    this.allowArchiveDownload,
    this.shareDownload,
    this.compress,
    this.webdav,
    this.sourceBatch,
    this.advanceDelete,
  });

  CloudreveSiteConfGroupData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    allowShare = json['allowShare'];
    allowRemoteDownload = json['allowRemoteDownload'];
    allowArchiveDownload = json['allowArchiveDownload'];
    shareDownload = json['shareDownload'];
    compress = json['compress'];
    webdav = json['webdav'];
    sourceBatch = json['sourceBatch'];
    advanceDelete = json['advanceDelete'];
  }

  num? id;
  String? name;
  bool? allowShare;
  bool? allowRemoteDownload;
  bool? allowArchiveDownload;
  bool? shareDownload;
  bool? compress;
  bool? webdav;
  num? sourceBatch;
  bool? advanceDelete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['allowShare'] = allowShare;
    map['allowRemoteDownload'] = allowRemoteDownload;
    map['allowArchiveDownload'] = allowArchiveDownload;
    map['shareDownload'] = shareDownload;
    map['compress'] = compress;
    map['webdav'] = webdav;
    map['sourceBatch'] = sourceBatch;
    map['advanceDelete'] = advanceDelete;
    return map;
  }
}
