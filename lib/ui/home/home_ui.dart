import 'package:syncreve/base/ui.dart';
import 'package:syncreve/ui/home/home_ui_model.dart';

class HomeUI extends BaseUI<HomeUIModel> {
  @override
  Widget? buildBody(BuildContext context, HomeUIModel model) {
    return Container();
  }

  @override
  String getUITitle(BuildContext context, HomeUIModel model) => "Syncreve";

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, HomeUIModel model) =>
      null;
}
