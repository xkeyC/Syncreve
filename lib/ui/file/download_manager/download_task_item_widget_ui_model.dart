import 'dart:async';

import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/io/downloader.dart';
import 'package:syncreve/data/app/grpc_file_download_info_data.dart';
import 'package:syncreve/generated/grpc/libsyncreve/protos/file_sync.pbenum.dart';
import 'package:syncreve/widgets/dialogs.dart';

import 'download_manager_ui_model.dart';

class DownloadTaskItemWidgetUIModel extends BaseUIModel {
  StreamSubscription? downloadSub;

  num downloadSpeed = 0;
  num _lastDownloadedSize = 0;

  @override
  void initModel() {
    if (itemData.status == Downloader.fileDownloadQueueStatusDownloading) {
      _listenDownloadInfoStream();
    }
    super.initModel();
  }

  final DownloadManagerUIModel downloadManagerUIModel;
  GrpcFileDownloadInfoItemData itemData;
  final statusMap = {
    Downloader.fileDownloadQueueStatusDownloading: "Downloading",
    Downloader.fileDownloadQueueStatusWaiting: "Waiting",
    Downloader.fileDownloadQueueStatusError: "Error",
    Downloader.fileDownloadQueueStatusDone: "Complete",
  };

  DownloadTaskItemWidgetUIModel(
      {required this.itemData, required this.downloadManagerUIModel});

  getDownloadStatusText(int? status) {
    return statusMap[status] ?? "?";
  }

  double? getDownloadProgressValue(GrpcFileDownloadInfoItemData itemData) {
    final fileSize = itemData.contentLength ?? 1;
    if (fileSize == 0) return null;
    final p =
        (itemData.downloadedSize?.toDouble() ?? 0.0) / fileSize.toDouble();
    return p;
  }

  void _listenDownloadInfoStream() async {
    downloadSub = Downloader.getDownloadInfoStream(DownloadInfoRequestType.All,
        id: itemData.id, onData: _onDownloadInfoUpdate);
    _downloadSpeeder();
  }

  void _onDownloadInfoUpdate(GrpcFileDownloadInfoData value) {
    if (value.infoMap != null) {
      final newV = value.infoMap![itemData.id];
      if (newV != null) {
        itemData = GrpcFileDownloadInfoItemData.fromJson(newV);
        notifyListeners();
        if (itemData.status != Downloader.fileDownloadQueueStatusDownloading) {
          downloadSub?.cancel();
          downloadSub = null;
          downloadManagerUIModel.loadData();
        }
      }
    }
  }

  void _downloadSpeeder() async {
    while (downloadSub != null) {
      if (downloadSpeed == 0) {
        downloadSpeed = itemData.downloadedSize ?? 0;
        _lastDownloadedSize = downloadSpeed;
      } else {
        final sp = (itemData.downloadedSize ?? 0) - _lastDownloadedSize;
        if (sp != 0) {
          downloadSpeed = sp;
          _lastDownloadedSize = itemData.downloadedSize ?? 0;
          notifyListeners();
        }
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  void dispose() {
    downloadSub?.cancel();
    downloadSub = null;
    super.dispose();
  }

  onTap() {
    switch (itemData.status) {
      case Downloader.fileDownloadQueueStatusError:
        return _showError();
    }
  }

  _showError() {
    AppDialogs.showConfirm(context!,
        title: "Retry?", content: itemData.errorInfo);
  }
}
