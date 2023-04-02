import 'package:syncreve/api/cloudreve_site_api.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/data/app/account.dart';
import 'package:syncreve/ui/home_ui.dart';
import 'package:syncreve/ui/setup/setup_ui.dart';
import 'package:syncreve/ui/setup/setup_ui_model.dart';
import 'package:syncreve/widgets/dialogs.dart';

class AccountEditUIModel extends BaseUIModel {
  final AppAccountData accountData;

  AccountEditUIModel({required this.accountData});

  String accountStatus = "...";

  @override
  Future loadData() async {
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
}
