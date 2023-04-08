import 'dart:io';

import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/io/path_tools.dart';

class FileLocalUIModel extends BaseUIModel {
  List<String> path = [];
  String pathString = "";
  List<FileSystemEntity>? list;

  final pathScrollCtrl = ScrollController();

  final bool isSelectDirMode;

  FileLocalUIModel({this.isSelectDirMode = true});

  @override
  void initModel() {
    onChangeDir(AppPathTools.userDownloadPath.split("/"));
    super.initModel();
  }

  @override
  Future loadData() async {
    pathString = path.join("/");
    final dir = Directory(pathString);
    if (await dir.exists() != true) {
      await handleError(() => dir.create(recursive: true),
          showFullScreenError: true);
    }

    list = await handleError(
        () async => dir.listSync(recursive: false, followLinks: true));
    notifyListeners();
  }

  String getPathName(String fullPath) {
    return fullPath.replaceFirst("$pathString/", "");
  }

  @override
  Future reloadData() async {
    list = null;
    notifyListeners();
    return loadData();
  }

  @override
  Future onErrorReloadData() async {
    return onChangeDir(AppPathTools.userDownloadPath.split("/"));
  }

  Future<void> onChangeDir(List<String> list) async {
    final lastPath = path;
    path = list;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 32));
    pathScrollCtrl.animateTo(pathScrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);
    await reloadData();
    if (this.list == null) {
      return onChangeDir(lastPath);
    }
  }

  void onSelect() {
    dPrint("<$runtimeType> onSelect $pathString");
    Navigator.pop(context!, pathString);
  }

  void onCreateNewFolder() {}
}
