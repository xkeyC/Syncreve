import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:syncreve/base/ui_model.dart';

class SetupWebviewUIModel extends BaseUIModel {
  String initUrl;
  final Function(String cookies) onLogin;

  SetupWebviewUIModel({required this.initUrl, required this.onLogin});

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  CookieManager cookieManager = CookieManager.instance();

  void onUpdateVisitedHistory(
      InAppWebViewController controller, WebUri? url, bool? isReload) async {
    if (url?.rawValue.contains("/home") ?? false) {
      final cookies = await cookieManager.getCookie(
        url: WebUri(initUrl),
        name: 'cloudreve-session',
      );
      if (cookies != null) {
        onLogin("cloudreve-session=${cookies.value}");
      }
    }
  }

  @override
  void dispose() {
    cookieManager.deleteAllCookies();
    webViewController?.clearCache();
    super.dispose();
  }
}
