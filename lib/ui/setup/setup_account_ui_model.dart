import 'package:syncreve/api/cloudreve_site_api.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/conf.dart';
import 'package:syncreve/data/site/cloudreve_site_conf_data.dart';
import 'package:syncreve/ui/home/home_ui.dart';
import 'package:syncreve/ui/home/home_ui_model.dart';

class SetupAccountUIModel extends BaseUIModel {
  final String workingUrl;
  final String cookies;

  SetupAccountUIModel({required this.workingUrl, required this.cookies});

  CloudreveSiteConfData? cloudreveSiteConfData;

  @override
  void initModel() {
    super.initModel();
    _getUserData();
  }

  _getUserData() async {
    AppConf.cloudreveSession = cookies;
    final conf = await handleError(
        () => CloudreveSiteApi.getConfData(workingUrl),
        showFullScreenError: true);
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
    BaseUIContainer(uiCreate: () => HomeUI(), modelCreate: () => HomeUIModel())
        .pushAndRemoveUntil(context!);
  }
}
