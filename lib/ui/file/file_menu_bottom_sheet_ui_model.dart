import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
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
      filesSize = 0;
      for (var value in files) {
        filesSize += int.tryParse(value.size?.toString() ?? "") ?? 0;
      }
    }
    notifyListeners();
  }

  void onClosing() {}

  Future<void> onTapMenu(String key) async {
    switch (key) {
      case "clear_cache":
        final path = Downloader.getTempFilePath(files[0]).fileSavedFullPath!;
        final file = File(path);
        if (await file.exists()) {
          EasyLoading.show();
          try {
            await file.delete(recursive: true);
            await Future.delayed(const Duration(milliseconds: 500));
            await loadData();
          } catch (e) {
            showToast(e.toString());
          }
          EasyLoading.dismiss();
        }
        return;
    }
    Navigator.pop(context!, key);
  }
}
