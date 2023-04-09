import 'package:filesize/filesize.dart';
import 'package:syncreve/base/ui.dart';
import 'package:syncreve/common/io/downloader.dart';

import 'download_task_item_widget_ui_model.dart';

class DownloadTaskItemWidgetUI extends BaseUI<DownloadTaskItemWidgetUIModel> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(provider);
    final itemData = model.itemData;
    return InkWell(
      onTap: model.onTap,
      child: fastPadding(
          all: 12,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.file_present_sharp, size: 32),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 84,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${itemData.fileName}",
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 2),
                        Text(
                          "${filesize(itemData.downloadedSize ?? 0)}${itemData.status == Downloader.fileDownloadQueueStatusDownloading ? "/${filesize(itemData.contentLength ?? 0)}" : ""} ${model.getDownloadStatusText(itemData.status)} "
                          "${itemData.status == Downloader.fileDownloadQueueStatusError ? "${itemData.errorInfo}" : ""}"
                          "${itemData.status == Downloader.fileDownloadQueueStatusDownloading ? "  ${filesize(model.downloadSpeed)}/s" : ""}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).unselectedWidgetColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  )
                ],
              ),
              if (itemData.status ==
                      Downloader.fileDownloadQueueStatusDownloading ||
                  model.isDownloadComplete) ...[
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: model.getDownloadProgressValue(itemData),
                ),
              ]
            ],
          )),
    );
  }

  Widget makeInfoRow(String name, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
          const Spacer(),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget? buildBody(
          BuildContext context, DownloadTaskItemWidgetUIModel model) =>
      null;

  @override
  String getUITitle(
          BuildContext context, DownloadTaskItemWidgetUIModel model) =>
      "";
}
