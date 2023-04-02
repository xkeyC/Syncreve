import 'package:syncreve/base/ui.dart';

import 'file_open_temp_dialog_ui_model.dart';

class FileOpenTempDialogUI extends BaseUI<FileOpenTempDialogUIModel> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(provider);
    return WillPopScope(
        onWillPop: model.willPop,
        child: AlertDialog(
          title: const Text("Opening file ..."),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              LinearProgressIndicator(
                value: model.getDownloadProgressValue(),
              ),
              const SizedBox(height: 12),
            ],
          ),
          actions: [
            TextButton(
              onPressed: model.onCancel,
              child: const Text("CANCEL"),
            )
          ],
        ));
  }

  @override
  Widget? buildBody(BuildContext context, FileOpenTempDialogUIModel model) =>
      null;

  @override
  String getUITitle(BuildContext context, FileOpenTempDialogUIModel model) =>
      "";
}
