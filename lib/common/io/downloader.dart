import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:syncreve/base/base_utils.dart';
import 'package:syncreve/common/grpc/grpc_manager.dart';
import 'package:syncreve/common/io/path_tools.dart';
import 'package:syncreve/data/app/app_file_save_path_data.dart';
import 'package:syncreve/data/app/grpc_file_download_info_data.dart';
import 'package:syncreve/data/file/cloudreve_file_data.dart';
import 'package:syncreve/generated/grpc/libsyncreve/protos/file_sync.pbgrpc.dart';

class Downloader {
  static const fileDownloadQueueStatusWaiting = 0;
  static const fileDownloadQueueStatusDownloading = 1;
  static const fileDownloadQueueStatusDone = 2;
  static const fileDownloadQueueStatusError = -1;

  static Future<List<String>> addDownloadTask(
      {required String workingUrl,
      required List<String> fileIDs,
      required String savePath,
      required String fileName,
      required String cookie,
      required DownloadInfoRequestType type,
      required String instanceUrl}) async {
    final r = DownloadTaskRequest(
        workingUrl: workingUrl,
        instanceUrl: instanceUrl,
        fileID: fileIDs,
        savePath: savePath,
        fileName: fileName,
        cookie: cookie,
        downLoadType: type);

    if (await File("$savePath/$fileName").exists()) {
      dPrint("[Downloader] addDownloadTask file exists");
      throw "file exists";
    }

    dPrint("[Downloader] addDownloadTask r==$r");

    final ids = await AppGRPCManager.addDownloadTask(r);
    dPrint("[Downloader] addDownloadTask result.ids==$ids");
    return ids;
  }

  static StreamSubscription getDownloadInfoStream(DownloadInfoRequestType type,
      {String? id, void Function(GrpcFileDownloadInfoData value)? onData}) {
    final s = AppGRPCManager.getDownloadInfoStream(
        DownloadInfoRequest(id: id, type: type));
    return s.listen((value) {
      final data = GrpcFileDownloadInfoData.fromJson(
          json.decode(utf8.decode(value.data)));
      // dPrint("[Downloader] info stream :${data.toJson()}");
      onData?.call(data);
    }, onDone: () {}, onError: (error, stackTrace) {}, cancelOnError: true);
  }

  static Future<String> cancelDownloadTask(String id) {
    return AppGRPCManager.cancelDownloadTask(id);
  }

  static AppFileSavePathData getTempFilePath(
      CloudreveFileObjectsData fileData) {
    final savePath =
        "${AppPathTools.tempDownloadPath}/${fileData.id ?? "no_id"}/";
    final fileName = fileData.name ?? fileData.id ?? "no_name";
    final filePath = getFilePath(savePath, fileName);
    return AppFileSavePathData(
        fileSavedFullPath: filePath, savePath: savePath, fileName: fileName);
  }

  static String getFilePath(String savePath, String fileName) {
    return "$savePath/$fileName";
  }
}
