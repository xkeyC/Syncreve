import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/ui/home/home_account_ui_model.dart';
import 'package:syncreve/ui/home/home_file_ui_model.dart';
import 'package:syncreve/ui/home/home_sync_ui_model.dart';

class HomeUIModel extends BaseUIModel {
  int curPageIndex = 0;

  int _lastChangePageTime = DateTime.now().millisecondsSinceEpoch;

  bool get canChangePageIndex =>
      DateTime.now().millisecondsSinceEpoch - _lastChangePageTime >= 300;

  @override
  BaseUIModel? onCreateChildUIModel(modelKey) {
    switch (modelKey) {
      case "file":
        return HomeFileUIModel(homeUIModel: this);
      case "sync":
        return HomeSyncUIModel(homeUIModel: this);
      case "account":
        return HomeAccountUIModel(homeUIModel: this);
    }
    return null;
  }

  void onChangePageIndex(int index) {
    curPageIndex = index;
    _lastChangePageTime = DateTime.now().millisecondsSinceEpoch;
    notifyListeners();
  }
}
