import 'package:syncreve/common/utils/string.dart';
import 'package:syncreve/data/site/cloudreve_site_conf_data.dart';

class AppAccountData {
  CloudreveSiteConfData cloudreveSiteConfData;
  String cloudreveSession;
  String instanceUrl;

  AppAccountData(
      this.cloudreveSiteConfData, this.cloudreveSession, this.instanceUrl);

  Map<String, dynamic> toJson() {
    return {
      "cloudreveSiteConfData": cloudreveSiteConfData.toJson(),
      "cloudreveSession": cloudreveSession,
      "instanceUrl": instanceUrl,
    };
  }

  factory AppAccountData.formJson(Map json) {
    return AppAccountData(
        CloudreveSiteConfData.fromJson(
          json["cloudreveSiteConfData"],
        ),
        json["cloudreveSession"],
        json["instanceUrl"]);
  }

  String get id =>
      StringUtil.getSha1("${cloudreveSiteConfData.user?.id}_$instanceUrl");

  String? get userName => cloudreveSiteConfData.user?.userName;

  String? get userID => cloudreveSiteConfData.user?.id;
}
