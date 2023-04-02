import 'package:syncreve/api/cloudreve_site_api.dart';
import 'package:syncreve/base/base_utils.dart';
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
    bool getAlia = false;
    for (var url in aliasHost!) {
      try {
        final u = await CloudreveSiteApi.getConfData(url);
        if (u.user?.userName == userName) {
          workingUrl = url;
          getAlia = true;
          dPrint("[AppAccountData] checkNewWorkingUrl pass ($url)");
          return;
        }
        dPrint(
            "[AppAccountData] checkNewWorkingUrl ($url) ${u.user?.userName} <> $userName");
      } catch (e) {
        dPrint("[AppAccountData] checkNewWorkingUrl Error:$e");

        continue;
      }
    }
    if (!getAlia) {
      workingUrl = instanceUrl;
    }
  }
}
