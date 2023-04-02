import 'package:syncreve/api/cloudreve_site_api.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/conf.dart';
import 'package:syncreve/data/site/cloudreve_site_conf_data.dart';
import 'package:syncreve/ui/home_ui.dart';

class SetupAccountUIModel extends BaseUIModel {
  final String workingUrl;
  final String cookies;
  final bool isFirstLaunch;

  SetupAccountUIModel(
      {required this.workingUrl,
      required this.cookies,
      this.isFirstLaunch = true});

  CloudreveSiteConfData? cloudreveSiteConfData;

  @override
  void initModel() {
    super.initModel();
    _getUserData();
  }

  _getUserData() async {
    AppConf.tempSession = cookies;
    final conf = await handleError(
        () => CloudreveSiteApi.getConfData(workingUrl),
        showFullScreenError: true);
    AppConf.tempSession = null;
    if (conf == null) return;
    if (conf.user == null || conf.user?.anonymous != false) {
      uiErrorMsg = "login Failed";
      notifyListeners();
      return;
    }
    cloudreveSiteConfData = conf;
    notifyListeners();
  }

  Future<void> checkAccount() async {
    final account = await AppAccountManager.addAccount(
        cloudreveSiteConfData!, cookies, workingUrl);
    await AppAccountManager.setWorkingAccount(account.id);
    HomeUI.pushAndRemove(context!);
  }
}
