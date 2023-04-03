import 'package:syncreve/api/cloudreve_site_api.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/data/app/account.dart';
import 'package:syncreve/ui/account/account_edit_ui_model.dart';
import 'package:syncreve/ui/setup/setup_ui.dart';
import 'package:syncreve/ui/setup/setup_ui_model.dart';

import 'account_edit_ui.dart';

class AccountSwitchBottomSheetUIModel extends BaseUIModel {
  List<AppAccountData>? accounts;
  Map<String, bool> checkAccount = {};

  @override
  Future loadData() async {
    checkAccount.clear();
    accounts = await AppAccountManager.getAccounts();
    final index = accounts?.indexWhere(
        (element) => element.id == AppAccountManager.workingAccount?.id);
    if (index != null) {
      accounts?[index] = AppAccountManager.workingAccount!;
    }
    notifyListeners();
    if (accounts != null) {
      for (var value in accounts!) {
        try {
          final c = await CloudreveSiteApi.getConfData(value.workingUrl);
          if (c.user != null && c.user?.userName == value.userName) {
            checkAccount[value.id] = true;
          } else {
            checkAccount[value.id] = false;
          }
        } catch (e) {
          checkAccount[value.id] = false;
        }
        dPrint("checkAccount ${value.id} ${checkAccount[value.id]}");
        notifyListeners();
      }
    }
  }

  void goEdit(AppAccountData account) {
    BaseUIContainer(
            uiCreate: () => AccountEditUI(),
            modelCreate: () => AccountEditUIModel(accountData: account))
        .push(context!);
  }

  void onNewAccount() async {
    BaseUIContainer(
        uiCreate: () => SetupUI(),
        modelCreate: () => SetupUIModel(isFirstLaunch: false)).push(context!);
  }

  void onSelectAccount(AppAccountData account) {
    Navigator.pop(context!, account);
  }
}
