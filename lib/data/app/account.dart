import 'package:dio/dio.dart';
import 'package:syncreve/base/base_utils.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/utils/string.dart';
import 'package:syncreve/data/site/cloudreve_site_conf_data.dart';

class AppAccountData {
  CloudreveSiteConfData cloudreveSiteConfData;
  String cloudreveSession;
  String instanceUrl;
  List<String>? aliasHost;
  late String workingUrl = instanceUrl;

  AppAccountData(
      this.cloudreveSiteConfData, this.cloudreveSession, this.instanceUrl,
      {this.aliasHost});

  Map<String, dynamic> toJson() {
    return {
      "cloudreveSiteConfData": cloudreveSiteConfData.toJson(),
      "cloudreveSession": cloudreveSession,
      "instanceUrl": instanceUrl,
      "aliasHost": aliasHost,
    };
  }

  factory AppAccountData.formJson(Map json) {
    return AppAccountData(
        CloudreveSiteConfData.fromJson(
          json["cloudreveSiteConfData"],
        ),
        json["cloudreveSession"],
        json["instanceUrl"],
        aliasHost: json["aliasHost"]);
  }

  String get id =>
      StringUtil.getSha1("${cloudreveSiteConfData.user?.id}_$instanceUrl");

  String? get userName => cloudreveSiteConfData.user?.userName;

  String? get userID => cloudreveSiteConfData.user?.id;

  Future checkNewWorkingUrl() async {
    if (aliasHost == null) {
      return;
    }
    final dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 3)));
    for (var url in aliasHost!) {
      try {
        final cookie = await AppAccountManager.getUrlCookie(url);
        dPrint(
            "[AppAccountData] checkNewWorkingUrl start:$url cookie==$cookie");
        final r = await dio.get("$url/api/v3/site/config",
            options: Options(
              headers: {"cookie": cookie},
            ));
        dPrint(
            "[AppAccountData] checkNewWorkingUrl start:$url data==${r.data}");
        final d = CloudreveSiteConfData.fromJson(r.data["data"]);
        if (d.user?.userName == userName) {
          workingUrl = url;
          dPrint("[AppAccountData] checkNewWorkingUrl work:$workingUrl");
          return;
        }
        dPrint(
            "[AppAccountData] checkNewWorkingUrl failed: account error ${d.user?.userName} <> $userName");
      } catch (e) {
        dPrint("[AppAccountData] checkNewWorkingUrl Error:$e");
      }
    }
    workingUrl = instanceUrl;
    dPrint(
        "[AppAccountData] checkNewWorkingUrl failed,use instanceUrl :$instanceUrl");
  }

  String get avatarUrl =>
      "${workingUrl == "" ? instanceUrl : workingUrl}/api/v3/user/avatar/$userID/l";
}
