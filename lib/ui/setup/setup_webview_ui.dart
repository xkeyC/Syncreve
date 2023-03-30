import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:syncreve/base/ui.dart';
import 'setup_webview_ui_model.dart';

class SetupWebviewUI extends BaseUI<SetupWebviewUIModel> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(provider);
    if (Platform.isAndroid || Platform.isIOS) {
      return mobileWebView(context, model);
    } else {
      return const SizedBox();
    }
  }

  Widget mobileWebView(BuildContext context, SetupWebviewUIModel model) {
    return InAppWebView(
      initialSettings: model.settings,
      initialUrlRequest: URLRequest(
        url: WebUri(model.initUrl),
      ),
      onWebViewCreated: (ctrl) {
        model.webViewController = ctrl;
      },
      onUpdateVisitedHistory: model.onUpdateVisitedHistory,
    );
  }

  @override
  Widget? buildBody(BuildContext context, SetupWebviewUIModel model) => null;

  @override
  String getUITitle(BuildContext context, SetupWebviewUIModel model) => "";
}
