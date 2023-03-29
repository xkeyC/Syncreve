class AppResultListData {
  AppResultListData({
    this.pageNumber,
    this.pageSize,
    this.rows,
    this.sumLine,
    this.sumPage,
  });

  AppResultListData.fromJson(dynamic json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    if (json['rows'] != null) {
      rows = [];
      json['rows'].forEach((v) {
        rows?.add(v);
      });
    }
    sumLine = json['sumLine'];
    sumPage = json['sumPage'];
  }

  int? pageNumber;
  int? pageSize;
  List<dynamic>? rows;
  int? sumLine;
  int? sumPage;

  AppResultListData copyWith({
    int? pageNumber,
    int? pageSize,
    List<dynamic>? rows,
    int? sumLine,
    int? sumPage,
  }) =>
      AppResultListData(
        pageNumber: pageNumber ?? this.pageNumber,
        pageSize: pageSize ?? this.pageSize,
        rows: rows ?? this.rows,
        sumLine: sumLine ?? this.sumLine,
        sumPage: sumPage ?? this.sumPage,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pageNumber'] = pageNumber;
    map['pageSize'] = pageSize;
    if (rows != null) {
      map['rows'] = rows?.map((v) => v.toJson()).toList();
    }
    map['sumLine'] = sumLine;
    map['sumPage'] = sumPage;
    return map;
  }
}
