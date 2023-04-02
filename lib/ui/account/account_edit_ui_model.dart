import 'package:syncreve/api/cloudreve_site_api.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/data/app/account.dart';
import 'package:syncreve/ui/home_ui.dart';
import 'package:syncreve/ui/setup/setup_ui.dart';
import 'package:syncreve/ui/setup/setup_ui_model.dart';
import 'package:syncreve/widgets/dialogs.dart';

class AccountEditUIModel extends BaseUIModel {
  AppAccountData accountData;

  final aliasHostCtrl = TextEditingController();

  AccountEditUIModel({required this.accountData});

  String accountStatus = "...";

  @override
  Future loadData() async {
    aliasHostCtrl.text = "";
    if (accountData.aliasHost != null) {
      for (var ah in accountData.aliasHost!) {
        aliasHostCtrl.text += "$ah\n";
      }
    }
    try {
      final c = await CloudreveSiteApi.getConfData(accountData.instanceUrl);
      if (c.user != null) {
        accountStatus = "ok";
      } else {
        accountStatus = "reLogin required";
      }
      notifyListeners();
    } catch (e) {
      accountStatus = e.toString();
    }
    if (accountData.id == AppAccountManager.workingAccount?.id) {
      await AppAccountManager.workingAccount?.checkNewWorkingUrl();
      notifyListeners();
    }
  }

  Future<void> doLogout() async {
    final ok = await AppDialogs.showConfirm(context!,
        title: "Are you sure log out?",
        content: "All sync tasks for this account will be suspended");
    if (ok == true) {
      try {
        await AppAccountManager.delAccount(accountData.id);
      } catch (e) {
        if (e == "no_account") {
          SetupUI.pushAndRemove(context!);
          return;
        }
      }
      HomeUI.pushAndRemove(context!);
    }
  }

  void doReLogin() {
    BaseUIContainer(
        uiCreate: () => SetupUI(),
        modelCreate: () => SetupUIModel(
            isFirstLaunch: false,
            initUrl: accountData.instanceUrl)).push(context!);
  }

  void doUpdateAliasHost() {
    if (aliasHostCtrl.text.isNotEmpty) {
      final lines = aliasHostCtrl.text.split("\n");
      if (lines.last == "") {
        lines.removeLast();
      }
      final List<String> newLines = [];
      try {
        for (var ah in lines) {
          if (ah.startsWith("http://") || ah.startsWith("http://")) {
            newLines.add(
                ah.substring(0, ah.endsWith("/") ? ah.length - 1 : ah.length));
          } else {
            throw "$ah must start with http:// or https://";
          }
        }
        dPrint("newLines == $newLines");
        accountData.aliasHost = newLines;
        AppAccountManager.updateAccountData(accountData);
        if (AppAccountManager.workingAccount?.id == accountData.id) {
          accountData.workingUrl = "";
          loadData();
        }
        showToast("Success");
      } catch (e) {
        showToast(e.toString());
        return;
      }
    }
  }

  String? getWorkingUrl() {
    if (accountData.id == AppAccountManager.workingAccount?.id) {
      return AppAccountManager.workingAccount?.workingUrl;
    }
    return accountData.instanceUrl;
  }
}
