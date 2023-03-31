import 'package:syncreve/base/ui.dart';
import 'package:syncreve/ui/home/home_account_ui_model.dart';

class HomeAccountUI extends BaseUI<HomeAccountUIModel> {
  @override
  Widget? buildBody(BuildContext context, HomeAccountUIModel model) {
    return const Center(
      child: Text("Account"),
    );
  }

  @override
  String getUITitle(BuildContext context, HomeAccountUIModel model) => "";

  @override
  PreferredSizeWidget? buildAppbar(
          BuildContext context, HomeAccountUIModel model) =>
      null;
}
