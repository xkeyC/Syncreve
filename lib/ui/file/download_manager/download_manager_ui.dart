import 'package:syncreve/base/ui.dart';
import 'package:syncreve/data/app/grpc_file_download_info_data.dart';
import 'package:syncreve/ui/file/download_manager/download_task_item_widget_ui_model.dart';

import 'download_manager_ui_model.dart';
import 'download_task_item_widget_ui.dart';

class DownloadManagerUI extends BaseUI<DownloadManagerUIModel> {
  @override
  Widget? buildBody(BuildContext context, DownloadManagerUIModel model) {
    if (model.infoData == null) return null;
    if (model.infoData?.infoMap?.isNotEmpty != true) {
      return const Center(
        child: Text("No Download Task"),
      );
    }
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 6),
            Row(
              children: [
                const SizedBox(width: 12),
                Text(
                  "Downloading (${model.getDownloadTaskCountString(isWorkingCount: true)})",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if ((model.downloadingList?.length ?? 0) == 0)
              const SizedBox(
                height: 128,
                child: Center(
                  child: Text("No downloading"),
                ),
              ),
          ])),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            final itemData = model.downloadingList![index];
            return Card(
              elevation: .1,
              child: makeDownloadTaskItem(itemData, model,
                  key: Key("header_${itemData.id}")),
            );
          }, childCount: model.downloadingList?.length ?? 0))
        ];
      },
      body: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12))),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 12),
                  Text(
                    "Queue (${(model.downloadCountResult?.count.toInt() ?? 0)})",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        model.cleanAllComplete();
                      },
                      onLongPress: () {
                        model.cleanAllComplete(cleanError: true);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.clear_all, size: 16),
                          SizedBox(width: 6),
                          Text(
                            "Clean Complete",
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      )),
                  const SizedBox(width: 12)
                ],
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: model.bodyList?.length ?? 0,
                cacheExtent: 30,
                itemBuilder: (BuildContext context, int index) {
                  final itemData = model.bodyList![index];
                  return makeDownloadTaskItem(itemData, model,
                      key: Key("body_${itemData.id}_${itemData.status}"));
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeDownloadTaskItem(
      GrpcFileDownloadInfoItemData itemData, DownloadManagerUIModel model,
      {Key? key}) {
    return BaseUIContainer(
        key: key,
        uiCreate: () => DownloadTaskItemWidgetUI(),
        modelCreate: () => DownloadTaskItemWidgetUIModel(
            itemData: itemData, downloadManagerUIModel: model));
  }

  @override
  String getUITitle(BuildContext context, DownloadManagerUIModel model) =>
      "Downloads (${model.getDownloadTaskCountString()})";

  static Future push(BuildContext context) {
    return BaseUIContainer(
        uiCreate: () => DownloadManagerUI(),
        modelCreate: () => DownloadManagerUIModel()).push(context);
  }
}
