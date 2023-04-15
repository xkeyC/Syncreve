import 'dart:async';

import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/grpc/grpc_manager.dart';
import 'package:syncreve/common/io/downloader.dart';
import 'package:syncreve/data/app/grpc_file_download_info_data.dart';
import 'package:syncreve/generated/grpc/libsyncreve/protos/file_sync.pb.dart';

class DownloadManagerUIModel extends BaseUIModel {
  StreamSubscription? _downloadCountListenSub;

  DownloadCountResult? _downloadCountResult;

  DownloadCountResult? get downloadCountResult => _downloadCountResult;

  GrpcFileDownloadInfoData? infoData;

  List<GrpcFileDownloadInfoItemData>? downloadingList;
  List<GrpcFileDownloadInfoItemData>? bodyList;

  @override
  void initModel() {
    _updateDownloadTasks();
    _listenDownloadCount();
    _timer();
    super.initModel();
  }

  _updateDownloadTasks() async {
    infoData = await handleError(
        () => Downloader.getDownloadInfo(DownloadInfoRequestType.All),
        showFullScreenError: true);
    dPrint("${infoData?.infoMap}");
    if (infoData?.infoMap != null) {
      final List<GrpcFileDownloadInfoItemData> downloadingList = [];
      final List<GrpcFileDownloadInfoItemData> waitingList = [];
      final List<GrpcFileDownloadInfoItemData> errorList = [];
      final List<GrpcFileDownloadInfoItemData> doneList = [];
      for (var kv in infoData!.infoMap!.entries) {
        final item = GrpcFileDownloadInfoItemData.fromJson(kv.value);
        switch (item.status) {
          case Downloader.fileDownloadQueueStatusDownloading:
            downloadingList.add(item);
            break;
          case Downloader.fileDownloadQueueStatusWaiting:
            waitingList.add(item);
            break;
          case Downloader.fileDownloadQueueStatusError:
            errorList.add(item);
            break;
          default:
            doneList.add(item);
            break;
        }
      }
      this.downloadingList = downloadingList;
      bodyList = [];
      bodyList!.addAll(waitingList);
      bodyList!.addAll(errorList);
      bodyList!.addAll(doneList);
    }
    notifyListeners();
  }

  _listenDownloadCount({int tryCount = 0}) async {
    var c = tryCount;
    _downloadCountListenSub = AppGRPCManager.getDownloadCountStream().listen(
        (value) {
          if (c != 0) {
            c = 0;
          }
          dPrint(
              "<DownloadManagerUIModel> getDownloadCountStream: count == ${value.count} workingCount ${value.workingCount}");
          _downloadCountResult = value;
          notifyListeners();
        },
        cancelOnError: true,
        onError: (e, t) {
          c++;
          _downloadCountListenSub?.cancel();
          dPrint(
              "<DownloadManagerUIModel> getDownloadCountStream: onError $e $t");
          if (c >= 3) {
            return;
          }
          return _listenDownloadCount(tryCount: c);
        });
  }

  String getDownloadTaskCountString({bool isWorkingCount = false}) {
    if (isWorkingCount) {
      return "${_downloadCountResult?.workingCount.toInt() ?? 0}";
    }
    return "${_downloadCountResult?.count.toInt() ?? 0}";
  }

  @override
  void dispose() {
    _downloadCountListenSub?.cancel();
    _downloadCountListenSub = null;
    super.dispose();
  }

  void cleanAllComplete({bool cleanError = false}) {}

  void _timer() async {
    while (mounted) {
      _updateDownloadTasks();
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
