import 'package:hive/hive.dart';
import 'package:syncreve/common/conf.dart';
import 'package:syncreve/data/app/account.dart';
import 'package:syncreve/data/site/cloudreve_site_conf_data.dart';
import 'package:syncreve/global_ui_model.dart';

class AppAccountManager {
  static AppAccountData? _workingAccount;

  static AppAccountData? get workingAccount => _workingAccount;

  static Future init() async {
    final accountBox = await Hive.openBox("account");
    final workingAccountID = accountBox.get("working_account_id");
    if (workingAccountID == null) return;
    setWorkingAccount(workingAccountID);
  }

  static Future<AppAccountData> addAccount(
      CloudreveSiteConfData cloudreveSiteConfData,
      String cloudreveSession,
      String instanceUrl) async {
    final accountBox = await Hive.openBox("account");
    final accountData =
        AppAccountData(cloudreveSiteConfData, cloudreveSession, instanceUrl);
    await accountBox.put(accountData.id, accountData.toJson());
    return accountData;
  }

  static Future setWorkingAccount(String id) async {
    final accountBox = await Hive.openBox("account");
    final acJson = await accountBox.get(id);
    if (acJson == null) return;
    _workingAccount = AppAccountData.formJson(acJson);
    accountBox.put("working_account_id", _workingAccount?.id);
    AppConf.baseUrl = _workingAccount!.instanceUrl;
    globalUIModel.notifyListeners();
  }

  static Future<List<AppAccountData>> getAccounts() async {
    final accountBox = await Hive.openBox("account");
    List<AppAccountData> l = [];
    for (var k in accountBox.keys) {
      final acJson = await accountBox.get(k);
      if (acJson == null || acJson is String) continue;
      final account = AppAccountData.formJson(acJson);
      l.add(account);
    }
    return l;
  }

  static Future delAccount(String id) async {
    final accountBox = await Hive.openBox("account");
    await accountBox.delete(id);
  }

  static Future<String> getUrlCookie(String url) async {
    final l = await getAccounts();
    for (var value in l) {
      if (url.contains(value.instanceUrl)) {
        return value.cloudreveSession;
      }
      if (value.aliasHost != null) {
        for (var host in value.aliasHost!) {
          if (url.contains(host)) {
            return value.cloudreveSession;
          }
        }
      }
    }
    return "";
  }
}
