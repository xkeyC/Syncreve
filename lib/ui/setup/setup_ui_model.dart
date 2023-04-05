import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:syncreve/api/cloudreve_site_api.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/data/site/cloudreve_site_conf_data.dart';
import 'package:syncreve/ui/setup/setup_account_ui.dart';
import 'package:syncreve/ui/setup/setup_account_ui_model.dart';
import 'package:syncreve/ui/setup/setup_webview_ui_model.dart';
import 'package:syncreve/ui/tools/qr_scanner_ui.dart';
import 'package:syncreve/ui/tools/qr_scanner_ui_model.dart';

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
    dPrint("onWebviewLogin: url == $workingUrl   cookies == $cookies");
    if (_isJumped) return;
    _isJumped = true;
    BaseUIContainer(
        uiCreate: () => SetupAccountUI(),
        modelCreate: () => SetupAccountUIModel(
            workingUrl: workingUrl,
            cookies: cookies,
            isFirstLaunch: isFirstLaunch)).pushAndRemoveUntil(context!);
  }

  void doScan() async {
    String? url;
    await BaseUIContainer(
        uiCreate: () => QrScannerUI(),
        modelCreate: () =>
            QrScannerUIModel(onQrDetect: (BarcodeCapture barcodeCapture) async {
              for (var element in barcodeCapture.barcodes) {
                if (element.rawValue != null &&
                    (element.rawValue!.startsWith("http://") ||
                        element.rawValue!.startsWith("https://")) &&
                    element.rawValue!.contains("/api/v3/user/session/copy/")) {
                  url = element.rawValue;
                  return true;
                }
              }
              return false;
            })).push(context!);
    if (url != null) {
      _doQrLogin(url!);
    }
  }

  void _doQrLogin(String url) async {
    dPrint("QR URL == $url");
    final dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 10)));
    final w = url.substring(0, url.indexOf("/api/v3/user/session/copy/"));
    workingUrl = w;
    urlTextCtrl.text = w;
    try {
      EasyLoading.show();
      final r = await dio.get("$w/api/v3/site/config",
          options: Options(
            headers: {"X-Cr-ios": "Syncreve"},
          ));
      if (r.headers["set-cookie"] != null) {
        var cookie = r.headers["set-cookie"].toString();
        if (cookie.contains("; Path=/;")) {
          cookie = cookie.substring(1, cookie.indexOf("; Path=/;"));
        }
        final cr = await dio.get(url,
            options: Options(
              headers: {"X-Cr-ios": "Syncreve", "cookie": cookie},
            ));
        if (cr.statusCode == 200 && cr.data["code"] == 0) {
          onWebviewLogin(cookie);
        } else {
          showToast("QR Expired");
        }
      }
    } catch (e) {
      dPrint(e);
      showToast(e.toString());
    }
    EasyLoading.dismiss();
  }
}
