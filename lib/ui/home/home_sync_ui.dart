import 'package:syncreve/base/ui.dart';
import 'package:syncreve/ui/home/home_sync_ui_model.dart';

class HomeSyncUI extends BaseUI<HomeSyncUIModel> {
  @override
  Widget? buildBody(BuildContext context, HomeSyncUIModel model) {
    return const Center(
      child: Text("Sync"),
    );
  }

  @override
  String getUITitle(BuildContext context, HomeSyncUIModel model) => "";

  @override
  PreferredSizeWidget? buildAppbar(
          BuildContext context, HomeSyncUIModel model) =>
      null;
}
