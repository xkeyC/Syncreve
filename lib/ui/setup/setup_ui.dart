import 'package:syncreve/base/ui.dart';
import 'package:syncreve/ui/setup/setup_webview_ui.dart';
import 'package:syncreve/ui/setup/setup_webview_ui_model.dart';
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
            AnimatedSize(
              duration: const Duration(milliseconds: 800),
              child: Card(
                elevation: .3,
                child: fastPadding(
                    all: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (confData == null) ...[
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
                        ] else ...[
                          Center(
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.cloud_circle,
                                  color: Colors.green,
                                  size: 64,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  confData.title ?? "",
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ],
                      ],
                    )),
              ),
            ),
            const SizedBox(height: 12),
            if (confData == null)
              Center(
                child: FloatingActionButton(
                  onPressed:
                      model.isEnterButtonLoading ? null : model.onEnterUrl,
                  child: model.isEnterButtonLoading
                      ? makeLoading(context)
                      : const Icon(Icons.chevron_right),
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
    return makeAppbar(context, getUITitle(context, model), showBack: false);
  }
}
