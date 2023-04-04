import 'dart:async';

import 'package:hive/hive.dart';
import 'package:syncreve/api/cloudreve_file_api.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/data/app/account.dart';
import 'package:syncreve/data/file/cloudreve_file_data.dart';
import 'package:syncreve/ui/account/account_switch_bottom_sheet_ui.dart';
import 'package:syncreve/ui/account/account_switch_bottom_sheet_ui_model.dart';
import 'package:syncreve/ui/file/file_open_temp_dialog_ui.dart';
import 'package:syncreve/ui/file/file_open_temp_dialog_ui_model.dart';
import 'package:syncreve/ui/home_ui_model.dart';

class HomeFileUIModel extends BaseUIModel {
  final HomeUIModel homeUIModel;

  HomeFileUIModel({required this.homeUIModel});

  List<String> path = [];

  Map<String, bool> selectedFiles = {};

  bool _isCardFileList = true;

  bool get isCardFileList => _isCardFileList;

  bool get isInSelectMode => selectedFiles.isNotEmpty;

  CloudreveFileData? files;

  final pathScrollCtrl = ScrollController();

  @override
  void initModel() {
    _initSettings();
    super.initModel();
  }

  _initSettings() async {
    final settingsBox = await Hive.openBox("settings");
    _isCardFileList = settingsBox.get("file_list_style", defaultValue: true);
    notifyListeners();
  }

  @override
  Future loadData() async {
    final files = await handleError(() => CloudreveFileApi.ls(path),
        showFullScreenError: true);
    if (files == null) return;
    this.files = files;
    notifyListeners();
  }

  @override
  Future reloadData({bool? skipClean}) {
    selectedFiles.clear();
    notifyListeners();
    if (skipClean != true) {
      files = null;
      notifyListeners();
    }
    return super.reloadData();
  }

  @override
  Future onErrorReloadData() {
    path = [];
    files = null;
    return super.onErrorReloadData();
  }

  Future<void> onTapAvatar() async {
    final a = await showModalBottomSheet(
      context: context!,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BaseUIContainer(
            uiCreate: () => AccountSwitchBottomSheetUI(),
            modelCreate: () => AccountSwitchBottomSheetUIModel());
      },
    );
    if (a is AppAccountData) {
      await AppAccountManager.setWorkingAccount(a.id);
      onErrorReloadData();
      homeUIModel.notifyListeners();
    }
  }

  void goDownload() {}

  Future<void> onChangeListStyle() async {
    final settingsBox = await Hive.openBox("settings");
    _isCardFileList = !_isCardFileList;
    await settingsBox.put("file_list_style", _isCardFileList);
    notifyListeners();
  }

  Future<void> onChangeDir(List<String> path) async {
    if (files == null) return;
    this.path = path;
    reloadData();
    await Future.delayed(const Duration(milliseconds: 32));
    pathScrollCtrl.animateTo(pathScrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);
  }

  Future<void> onTapFile(CloudreveFileObjectsData file) async {
    if (file.type == "dir") {
      onChangeDir(path..add(file.name!));
    } else {
      showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BaseUIContainer(
              uiCreate: () => FileOpenTempDialogUI(),
              modelCreate: () =>
                  FileOpenTempDialogUIModel(fileObjectsData: file));
        },
      );
    }
  }

  Future<bool> willPop() async {
    if (isInSelectMode) {
      selectedFiles.clear();
      return false;
    }
    if (homeUIModel.curPageIndex == 0 && path.isNotEmpty) {
      path.remove(path.last);
      onChangeDir(path);
      return false;
    }
    return true;
  }

  Future<void> onSelected(CloudreveFileObjectsData file) async {
    if (selectedFiles[file.id] == true) {
      selectedFiles.remove(file.id);
    } else {
      selectedFiles[file.id!] = true;
    }
    notifyListeners();
  }

  bool isFileSelected(CloudreveFileObjectsData file) {
    return selectedFiles[file.id] == true;
  }
}
