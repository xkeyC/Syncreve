import 'package:syncreve/base/ui.dart';
import 'package:syncreve/ui/home/home_file_ui_model.dart';

class HomeFileUI extends BaseUI<HomeFileUIModel> {
  @override
  Widget? buildBody(BuildContext context, HomeFileUIModel model) {
    return const Center(
      child: Text("File"),
    );
  }

  @override
  String getUITitle(BuildContext context, HomeFileUIModel model) => "";

  @override
  PreferredSizeWidget? buildAppbar(
          BuildContext context, HomeFileUIModel model) =>
      null;
}
