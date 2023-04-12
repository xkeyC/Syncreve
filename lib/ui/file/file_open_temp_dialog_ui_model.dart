import 'dart:async';
import 'dart:io';

import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/io/downloader.dart';
import 'package:syncreve/common/io/path_tools.dart';
import 'package:syncreve/data/app/grpc_file_download_info_data.dart';
import 'package:syncreve/data/file/cloudreve_file_data.dart';
import 'package:syncreve/generated/grpc/libsyncreve/protos/file_sync.pb.dart';

class FileOpenTempDialogUIModel extends BaseUIModel {
  final CloudreveFileObjectsData fileObjectsData;

  FileOpenTempDialogUIModel({required this.fileObjectsData});

  String? downloadID;
  StreamSubscription? downloadSub;
  GrpcFileDownloadInfoItemData? fileDownloadInfoItemData;

  num downloadSpeed = 0;
  num _lastDownloadedSize = 0;

  Future<bool> willPop() async {
    return false;
  }

  @override
  Future loadData() async {
    final p = Downloader.getTempFilePath(fileObjectsData);
    if (await File(p.fileSavedFullPath!).exists()) {
      doOpenFile(p.fileSavedFullPath!);
      return;
    }

    try {
      downloadID = (await Downloader.addDownloadTask(
          workingUrl: AppAccountManager.workingAccount!.workingUrl,
          instanceUrl: AppAccountManager.workingAccount!.instanceUrl,
          fileInfo: [
            DownloadTaskRequestFileInfo(
                fileID: fileObjectsData.id!, fileName: p.fileName!)
          ],
          savePath: p.savePath!,
          cookie: AppAccountManager.workingAccount!.cloudreveSession,
          type: DownloadInfoRequestType.Temp))[0];
    } catch (e) {
      if (e == "file exists") {
        doOpenFile(p.fileSavedFullPath!);
        return;
      }
      dPrint("Downloader.addDownloadTask Error:$e");
      showToast("$e");
      onCancel(doCancel: false);
    }
    if (downloadID == null) return;
    notifyListeners();
    downloadSub = Downloader.getDownloadInfoStream(DownloadInfoRequestType.Temp,
        id: downloadID!, onData: _onDownloadInfoUpdate);
    _downloadSpeeder();
  }

  void onCancel({doCancel = true}) async {
    if (doCancel && downloadID != null) {
      final ok =
          await handleError(() => Downloader.cancelDownloadTask(downloadID!));
      if (ok == null) {
        return;
      }
    }
    downloadSub?.cancel();
    downloadSub = null;
    Navigator.pop(context!);
  }

  void _onDownloadInfoUpdate(GrpcFileDownloadInfoData info) {
    if (downloadSub == null) return;
    info.infoMap?.forEach((key, value) {
      if (key == downloadID) {
        final itemData = GrpcFileDownloadInfoItemData.fromJson(value);
        fileDownloadInfoItemData = itemData;
        notifyListeners();
        final filePath = Downloader.getFilePath(
            fileDownloadInfoItemData!.savePath!,
            fileDownloadInfoItemData!.fileName!);
        if (fileDownloadInfoItemData?.status ==
            Downloader.fileDownloadQueueStatusDone) {
          doOpenFile(filePath);
        } else if (fileDownloadInfoItemData?.status ==
            Downloader.fileDownloadQueueStatusError) {
          if (fileDownloadInfoItemData?.errorInfo == "file exist") {
            doOpenFile(filePath);
            return;
          }
          onCancel(doCancel: false);
          showToast(fileDownloadInfoItemData?.errorInfo ?? "Download Error");
        }
      }
    });
  }

  void doOpenFile(String filePath) async {
    AppPathTools.openFile(filePath);
    onCancel(doCancel: false);
  }

  @override
  void dispose() {
    downloadSub?.cancel();
    downloadSub = null;
    super.dispose();
  }

  double? getDownloadProgressValue() {
    final fileSize = getFileSize();
    if (fileSize == 0) return null;
    if (downloadID == null || fileDownloadInfoItemData == null) return null;
    final p = (fileDownloadInfoItemData?.downloadedSize?.toDouble() ?? 0.0) /
        fileSize.toDouble();
    return p;
  }

  int getFileSize() {
    if (fileDownloadInfoItemData?.downloadedSize == null ||
        fileDownloadInfoItemData?.downloadedSize == 0) {
      return (fileObjectsData.size?.toInt()) ?? 0;
    }
    return fileDownloadInfoItemData!.totalSize!.toInt();
  }

  void _downloadSpeeder() async {
    while (downloadSub != null) {
      if (downloadSpeed == 0) {
        downloadSpeed = fileDownloadInfoItemData?.downloadedSize ?? 0;
        _lastDownloadedSize = downloadSpeed;
      } else {
        final sp = (fileDownloadInfoItemData?.downloadedSize ?? 0) -
            _lastDownloadedSize;
        if (sp != 0) {
          downloadSpeed = sp;
          _lastDownloadedSize = fileDownloadInfoItemData?.downloadedSize ?? 0;
          notifyListeners();
        }
        _lastDownloadedSize = fileDownloadInfoItemData?.downloadedSize ?? 0;
      }
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
