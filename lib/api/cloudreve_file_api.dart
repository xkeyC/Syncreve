import 'package:syncreve/base/api.dart';
import 'package:syncreve/common/io/http.dart';
import 'package:syncreve/data/file/cloudreve_file_data.dart';

class CloudreveFileApi extends BaseApi {
  static Future<CloudreveFileData> ls(List<String> path) async {
    final sb = StringBuffer();
    sb.write("/");
    for (var p in path) {
      sb.write(p);
      sb.write("/");
    }
    var ps = sb.toString();
    if (ps.endsWith("/")) {
      ps = ps.substring(0, ps.length - 1);
    }
    ps = Uri.encodeComponent(ps);
    return CloudreveFileData.fromJson(
        (await AppHttp.get("/api/v3/directory$ps")).data);
  }

  static Future<String> download(String id) async {
    return (await AppHttp.put("/api/v3/file/download/$id")).data;
  }
}
