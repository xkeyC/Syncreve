import 'package:filesize/filesize.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/utils/string.dart';
import 'package:syncreve/data/app/menu_button_data.dart';
import 'package:syncreve/data/file/cloudreve_file_data.dart';
import 'package:syncreve/widgets/src/cache_image.dart';

import 'file_menu_bottom_sheet_ui_model.dart';

class FileMenuBottomSheetUI extends BaseUI<FileMenuBottomSheetUIModel> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(provider);
    final filesInfo = model.files;
    return fastPadding(
        all: 6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            makFileInfoCard(filesInfo, model),
            const SizedBox(height: 6),
            makeActionList(context, filesInfo, model),
            makeSafeAre(context)
          ],
        ));
  }

  Widget makeActionList(
      BuildContext context,
      List<CloudreveFileObjectsData> filesInfo,
      FileMenuBottomSheetUIModel model) {
    final List<MenuButtonData> menu = [
      if (filesInfo.length == 1) ...[
        MenuButtonData("open", "Open", Icons.open_in_new),
        MenuButtonData("rename", "Rename", Icons.drive_file_rename_outline),
      ],
      if (model.isFileCached == true)
        MenuButtonData("clear_cache", "Clean cache", Icons.clear_all),
      MenuButtonData("copy", "Copy to", Icons.copy),
      MenuButtonData("move", "Move to", Icons.copy_all_sharp),
      MenuButtonData("compress", "Compress zip", Icons.compress),
      MenuButtonData("sync", "Sync rule", Icons.sync),
    ];

    return Column(
      children: [
        for (final i in menu)
          Card(
            elevation: .1,
            child: ListTile(
              leading: Icon(
                i.icon,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              title: Text(i.name),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                model.onTapMenu(i.actionKey);
              },
            ),
          ),
      ],
    );
  }

  Widget makFileInfoCard(List<CloudreveFileObjectsData> filesInfo,
      FileMenuBottomSheetUIModel model) {
    final fileInfo = filesInfo.length == 1 ? filesInfo[0] : null;
    final showLen = filesInfo.length - 2;
    return Card(
      child: fastPadding(
          all: 12,
          child: Column(
            children: [
              Row(
                children: [
                  makeFileIcon(context, filesInfo),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Text(
                    "${fileInfo == null ? "${filesInfo[0].name} , ${filesInfo[1].name} ... ${showLen == 0 ? "" : "And $showLen Files"} " : fileInfo.name}",
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
                        if (fileInfo != null) ...[
                          makeInfoRow("ID", fileInfo.id ?? ""),
                          if (fileInfo.type != "dir")
                            makeInfoRow("File Size", filesize(fileInfo.size)),
                          makeInfoRow(
                              "Create Date",
                              StringUtil.getTimeDateString(
                                  fileInfo.createDate ?? "")),
                          makeInfoRow(
                              "Update Date",
                              StringUtil.getTimeDateString(
                                  fileInfo.date ?? "")),
                          makeInfoRow("Path", fileInfo.path ?? ""),
                          if (fileInfo.type != "dir")
                            makeInfoRow("Locale Cache Status",
                                model.isFileCached == true ? "true" : "false"),
                        ] else ...[
                          makeInfoRow("Files number", "${filesInfo.length}"),
                          makeInfoRow("Files size",
                              "≈ ${model.filesSize == 0 ? "?" : "${filesize(model.filesSize)}+"}"),
                        ]
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

  Widget makeFileIcon(
      BuildContext context, List<CloudreveFileObjectsData> filesInfo) {
    const size = 64.0;

    if (filesInfo.length == 1) {
      final fileInfo = filesInfo[0];
      if (fileInfo.pic != "") {
        return CacheImage(
          "${AppAccountManager.workingAccount?.workingUrl}/api/v3/file/thumb/${fileInfo.id}",
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
    }
    return FaIcon(
      FontAwesomeIcons.fileCirclePlus,
      color: Theme.of(context).textTheme.bodySmall?.color,
      size: size * .6,
    );
  }

  @override
  Widget? buildBody(BuildContext context, FileMenuBottomSheetUIModel model) =>
      null;

  @override
  String getUITitle(BuildContext context, FileMenuBottomSheetUIModel model) =>
      "File Menu";

  static show(BuildContext context, List<CloudreveFileObjectsData> files) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BaseUIContainer(
            uiCreate: () => FileMenuBottomSheetUI(),
            modelCreate: () => FileMenuBottomSheetUIModel(files));
      },
    );
  }
}
