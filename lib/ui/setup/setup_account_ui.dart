import 'package:syncreve/base/ui_model.dart';
import 'setup_account_ui_model.dart';

class SetupAccountUI extends BaseUI<SetupAccountUIModel> {
  @override
  Widget? buildBody(BuildContext context, SetupAccountUIModel model) {
    return Container();
  }

  @override
  String getUITitle(BuildContext context, SetupAccountUIModel model) =>
      "Account setup";

  @override
  PreferredSizeWidget? buildAppbar(
      BuildContext context, SetupAccountUIModel model) {
    return makeAppbar(context, getUITitle(context, model), onBack: () {

    });
  }
}
