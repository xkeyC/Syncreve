import 'package:filesize/filesize.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/utils/string.dart';
import 'package:syncreve/data/file/cloudreve_file_data.dart';
import 'package:syncreve/widgets/src/cache_image.dart';

import 'file_menu_bottom_sheet_ui_model.dart';

class FileMenuBottomSheetUI extends BaseUI<FileMenuBottomSheetUIModel> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(provider);
    final fileInfo = model.file;
    return fastPadding(
        all: 6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            makFileInfoCard(fileInfo, model),
            const SizedBox(height: 6),
            makeActionList(context, fileInfo, model),
            makeSafeAre(context)
          ],
        ));
  }

  Widget makeActionList(BuildContext context, CloudreveFileObjectsData fileInfo,
      FileMenuBottomSheetUIModel model) {
    final iconColor = Theme.of(context).textTheme.bodyLarge?.color;
    final List<MapEntry<String, Widget>> menu = [
      if (fileInfo.type == "file")
        MapEntry("Open", Icon(Icons.open_in_new, color: iconColor)),
      if (model.isFileCached != true)
        MapEntry("Download", Icon(Icons.download, color: iconColor)),
      if (model.isFileCached == true) ...[
        MapEntry("Save to", Icon(Icons.save, color: iconColor)),
        MapEntry("Clean cache", Icon(Icons.clear_all, color: iconColor)),
      ]
    ];

    return Column(
      children: [
        for (final i in menu)
          Card(
            elevation: .1,
            child: ListTile(
              leading: i.value,
              title: Text(i.key),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                model.onTapMenu(i.key);
              },
            ),
          ),
      ],
    );
  }

  Widget makFileInfoCard(
      CloudreveFileObjectsData fileInfo, FileMenuBottomSheetUIModel model) {
    return Card(
      child: fastPadding(
          all: 12,
          child: Column(
            children: [
              Row(
                children: [
                  makeFileIcon(context, fileInfo),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(
                    "${fileInfo.name}",
                    maxLines: 3,
                  )),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12)),
                child: fastPadding(
                    all: 12,
                    child: Column(
                      children: [
                        makeInfoRow("ID", fileInfo.id ?? ""),
                        makeInfoRow("File Size", filesize(fileInfo.size)),
                        makeInfoRow(
                            "Create Date",
                            StringUtil.getTimeDateString(
                                fileInfo.createDate ?? "")),
                        makeInfoRow("Update Date",
                            StringUtil.getTimeDateString(fileInfo.date ?? "")),
                        makeInfoRow("Path", fileInfo.path ?? ""),
                        makeInfoRow("Locale Cache Status",
                            model.isFileCached == true ? "true" : "false"),
                      ],
                    )),
              )
            ],
          )),
    );
  }

  Widget makeInfoRow(String name, String value, {double? valueSize}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Row(
        children: [
          Expanded(
              child: Text(
            name,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).unselectedWidgetColor,
            ),
          )),
          Text(
            value,
            style: TextStyle(fontSize: valueSize ?? 14),
          ),
        ],
      ),
    );
  }

  Widget makeFileIcon(BuildContext context, CloudreveFileObjectsData fileInfo) {
    const size = 64.0;
    if (fileInfo.pic != "") {
      return CacheImage(
        "${AppAccountManager.workingAccount?.instanceUrl}/api/v3/file/thumb/${fileInfo.id}",
        loaderSize: size,
        fit: BoxFit.cover,
        height: size,
        width: size,
        cacheWidth: size.toInt() * 3,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(3), topRight: Radius.circular(3)),
      );
    }
    return Icon(
      fileInfo.type == "dir" ? Icons.folder : Icons.file_present_sharp,
      color: Theme.of(context).textTheme.bodySmall?.color,
      size: size,
    );
    return Container();
  }

  @override
  Widget? buildBody(BuildContext context, FileMenuBottomSheetUIModel model) =>
      null;

  @override
  String getUITitle(BuildContext context, FileMenuBottomSheetUIModel model) =>
      "File Menu";
}
