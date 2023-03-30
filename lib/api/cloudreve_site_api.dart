import 'package:syncreve/base/api.dart';
import 'package:syncreve/common/io/http.dart';
import 'package:syncreve/data/site/cloudreve_site_conf_data.dart';

class CloudreveSiteApi extends BaseApi {
  static Future<CloudreveSiteConfData> getConfData(String url) async {
    return CloudreveSiteConfData.fromJson(
        (await AppHttp.get("$url/api/v3/site/config")).data);
  }
}
