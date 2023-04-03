import 'dart:io';

import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/io/downloader.dart';
import 'package:syncreve/data/file/cloudreve_file_data.dart';

class FileMenuBottomSheetUIModel extends BaseUIModel {
  final CloudreveFileObjectsData file;

  FileMenuBottomSheetUIModel(this.file);

  bool? isFileCached;

  @override
  void initModel() {
    super.initModel();
    dPrint("FileMenuBottomSheetUI Show ,fileInfo == ${file.toJson()}");
  }

  @override
  Future loadData() async {
    final path = Downloader.getTempFilePath(file);
    if (await File(path.fileSavedFullPath!).exists()) {
      isFileCached = true;
    } else {
      isFileCached = false;
    }
    notifyListeners();
  }

  void onClosing() {}

  void onTapMenu(String key) {

  }
}
