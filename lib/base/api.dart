

import '../data/http_result.dart';

class BaseApi {
  static List<T> getListData<T>(dynamic data,
      {required T Function(Map json) onDecode}) {
    List<T> l = [];
    List? listSourceData;
    if (data is AppHttpResultData && data.data is List) {
      listSourceData = data.data;
    } else if (data is List) {
      listSourceData = data;
    }
    if (listSourceData == null) return l;
    for (final m in listSourceData) {
      l.add(onDecode(m));
    }
    return l;
  }
}
