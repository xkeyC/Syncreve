import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/ui/home/home_account_ui_model.dart';
import 'package:syncreve/ui/home/home_file_ui_model.dart';
import 'package:syncreve/ui/home/home_sync_ui_model.dart';

class HomeUIModel extends BaseUIModel {
  @override
  BaseUIModel? onCreateChildUIModel(modelKey) {
    switch (modelKey) {
      case "file":
        return HomeFileUIModel();
      case "sync":
        return HomeSyncUIModel();
      case "account":
        return HomeAccountUIModel();
    }
    return null;
  }
}
