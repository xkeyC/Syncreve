import 'dart:io';

import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/io/downloader.dart';
import 'package:syncreve/data/file/cloudreve_file_data.dart';

class FileMenuBottomSheetUIModel extends BaseUIModel {
  final List<CloudreveFileObjectsData> files;

  FileMenuBottomSheetUIModel(this.files);

  bool? isFileCached;

  int filesSize = 0;

  @override
  Future loadData() async {
    if (files.length == 1) {
      final path = Downloader.getTempFilePath(files[0]);
      if (await File(path.fileSavedFullPath!).exists()) {
        isFileCached = true;
      } else {
        isFileCached = false;
      }
    } else {
      for (var value in files) {
        filesSize += int.tryParse(value.size?.toString() ?? "") ?? 0;
      }
      notifyListeners();
    }

    notifyListeners();
  }

  void onClosing() {}

  void onTapMenu(String key) {}
}
