import 'dart:async';

import 'package:open_file_plus/open_file_plus.dart';
import 'package:syncreve/api/cloudreve_file_api.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/conf.dart';
import 'package:syncreve/common/io/downloader.dart';
import 'package:syncreve/data/app/grpc_file_download_info_data.dart';
import 'package:syncreve/data/file/cloudreve_file_data.dart';
import 'package:syncreve/generated/grpc/libsyncreve/protos/file_sync.pbenum.dart';

class FileOpenTempDialogUIModel extends BaseUIModel {
  final CloudreveFileObjectsData fileObjectsData;

  FileOpenTempDialogUIModel({required this.fileObjectsData});

  String? downloadID;
  StreamSubscription? downloadSub;
  GrpcFileDownloadInfoItemData? fileDownloadInfoItemData;

  Future<bool> willPop() async {
    return false;
  }

  @override
  Future loadData() async {
    final url =
        await handleError(() => CloudreveFileApi.download(fileObjectsData.id!));
    if (url == null) return;
    final savePath =
        "${AppConf.appTempDir}/temp_file/${fileObjectsData.id ?? "no_id"}/";
    final fileName = fileObjectsData.name ?? fileObjectsData.id ?? "no_name";

    try {
      downloadID = await Downloader.addDownloadTask(
          url: url,
          savePath: savePath,
          fileName: fileName,
          cookie: await AppAccountManager.getUrlCookie(url),
          type: DownloadInfoRequestType.Temp);
    } catch (e) {
      if (e == "file exists") {
        doOpenFile(Downloader.getFilePath(savePath, fileName));
        return;
      }
      showToast("$e");
      onCancel(doCancel: false);
    }
    if (downloadID == null) return;
    notifyListeners();
    downloadSub = Downloader.getDownloadInfoStream(DownloadInfoRequestType.Temp,
        id: downloadID!, onData: _onDownloadInfoUpdate);
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
        fileDownloadInfoItemData = GrpcFileDownloadInfoItemData.fromJson(value);
        notifyListeners();
        if (fileDownloadInfoItemData?.status ==
            Downloader.fileDownloadQueueStatusDone) {
          doOpenFile(Downloader.getFilePath(fileDownloadInfoItemData!.savePath!,
              fileDownloadInfoItemData!.fileName!));
        } else if (fileDownloadInfoItemData?.status ==
            Downloader.fileDownloadQueueStatusError) {
          onCancel(doCancel: false);
          showToast(fileDownloadInfoItemData?.errorInfo ?? "Download Error");
        }
      }
    });
  }

  void doOpenFile(String filePath) {
    OpenFile.open(filePath);
    onCancel(doCancel: false);
  }

  @override
  void dispose() {
    downloadSub?.cancel();
    super.dispose();
  }

  double? getDownloadProgressValue() {
    final fileSize = getFileSize();
    if (fileSize == 0) return null;
    if (downloadID == null && fileDownloadInfoItemData == null) return null;
    if (downloadID != null && fileDownloadInfoItemData == null) return 0;
    final p = (fileDownloadInfoItemData?.downloadedSize?.toDouble() ?? 0.0) /
        fileSize.toDouble();
    dPrint(
        "getDownloadProgressValue ${(fileDownloadInfoItemData?.downloadedSize?.toDouble() ?? 0)} / ${fileSize.toDouble()}} == $p");
    return p;
  }

  int getFileSize() {
    if (fileDownloadInfoItemData?.downloadedSize == null ||
        fileDownloadInfoItemData?.downloadedSize == 0) {
      return (fileObjectsData.size?.toInt()) ?? 0;
    }
    return fileDownloadInfoItemData!.contentLength!.toInt();
  }
}
