import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncreve/base/ui.dart';
import 'package:syncreve/ui/setup/setup_webview_ui.dart';
import 'package:syncreve/ui/setup/setup_webview_ui_model.dart';
import 'package:syncreve/widgets/src/fade_transition_route.dart';
import 'setup_ui_model.dart';

class SetupUI extends BaseUI<SetupUIModel> {
  @override
  Widget? buildBody(BuildContext context, SetupUIModel model) {
    final confData = model.cloudreveSiteConfData;
    return fastPadding(
        all: 6,
        child: Column(
          children: [
            if (confData == null) const SizedBox(height: 12),
            if (confData == null)
              Card(
                elevation: .3,
                child: fastPadding(
                    all: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Hero(
                              tag: "app_logo",
                              child: Icon(
                                Icons.cloud_circle,
                                color: Colors.indigoAccent,
                                size: 120,
                              )),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: model.urlTextCtrl,
                          decoration: const InputDecoration(
                            hintText: "Cloudreve Instance URL",
                          ),
                        ),
                      ],
                    )),
              ),
            if (confData == null) const SizedBox(height: 12),
            if (confData == null)
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      heroTag: UniqueKey(),
                      onPressed:
                          model.isEnterButtonLoading ? null : model.onEnterUrl,
                      child: model.isEnterButtonLoading
                          ? makeLoading(context)
                          : const Icon(Icons.chevron_right),
                    ),
                    const SizedBox(width: 16),
                    const Text("or"),
                    const SizedBox(width: 16),
                    FloatingActionButton(
                      heroTag: UniqueKey(),
                      onPressed: model.doScan,
                      child: SvgPicture.asset(
                        "assets/qrcode_scan.svg",
                        width: 24,
                        height: 24,
                        colorFilter: makeSvgColor(
                            Theme.of(context).textTheme.bodyLarge?.color ??
                                Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            if (confData != null)
              Expanded(
                  child: BaseUIContainer(
                      uiCreate: () => SetupWebviewUI(),
                      modelCreate: () =>
                          model.getChildUIModelProviders<SetupWebviewUIModel>(
                              SetupWebviewUIModel)))
          ],
        ));
  }

  @override
  String getUITitle(BuildContext context, SetupUIModel model) =>
      "Syncreve setup";

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, SetupUIModel model) {
    return makeAppbar(context, getUITitle(context, model),
        showBack: model.isFirstLaunch ? false : true);
  }

  static pushAndRemove(BuildContext context) {
    return Navigator.pushAndRemoveUntil(context,
        FadeTransitionRoute(builder: (BuildContext context) {
      return BaseUIContainer(
          uiCreate: () => SetupUI(), modelCreate: () => SetupUIModel());
    }), (_) => false);
  }
}
