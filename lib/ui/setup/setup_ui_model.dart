import 'package:syncreve/api/cloudreve_site_api.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/data/site/cloudreve_site_conf_data.dart';
import 'package:syncreve/ui/setup/setup_account_ui.dart';
import 'package:syncreve/ui/setup/setup_account_ui_model.dart';
import 'package:syncreve/ui/setup/setup_webview_ui_model.dart';

class SetupUIModel extends BaseUIModel {
  final bool isFirstLaunch;

  SetupUIModel({
    this.isFirstLaunch = true,
    this.initUrl = "",
  });

  String initUrl;
  CloudreveSiteConfData? cloudreveSiteConfData;

  final urlTextCtrl = TextEditingController();

  String workingUrl = "";

  bool isEnterButtonLoading = false;

  bool _isJumped = false;

  @override
  initModel() {
    super.initModel();
    urlTextCtrl.text = initUrl;
    if (initUrl.isNotEmpty) {
      onEnterUrl();
    }
  }

  _setLoading(bool b) {
    isEnterButtonLoading = b;
    notifyListeners();
  }

  void onEnterUrl() async {
    dismissKeyBoard();
    if (isEnterButtonLoading) return;
    _setLoading(true);
    var url = urlTextCtrl.text;
    if (Uri.parse(url).host.isEmpty) {
      showToast("URL Error");
      _setLoading(false);
      return;
    }
    if (url.endsWith("/")) {
      url = url.substring(0, url.length - 1);
      urlTextCtrl.text = url;
    }
    final data = await handleError(() => CloudreveSiteApi.getConfData(url));
    _setLoading(false);
    if (data == null) return;
    cloudreveSiteConfData = data;
    workingUrl = url;
    notifyListeners();
  }

  @override
  BaseUIModel? onCreateChildUIModel(modelKey) {
    switch (modelKey) {
      case SetupWebviewUIModel:
        return SetupWebviewUIModel(
            initUrl: "$workingUrl/login", onLogin: onWebviewLogin);
    }
    return null;
  }

  onWebviewLogin(String cookies) {
    if (_isJumped) return;
    _isJumped = true;
    BaseUIContainer(
        uiCreate: () => SetupAccountUI(),
        modelCreate: () => SetupAccountUIModel(
            workingUrl: workingUrl,
            cookies: cookies,
            isFirstLaunch: isFirstLaunch)).pushAndRemoveUntil(context!);
  }
}
