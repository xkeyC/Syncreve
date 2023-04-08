import 'dart:io';

import 'package:syncreve/base/ui.dart';

import 'file_local_ui_model.dart';

class FileLocalUI extends BaseUI<FileLocalUIModel> {
  @override
  Widget? buildBody(BuildContext context, FileLocalUIModel model) {
    if (model.list == null) return null;
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return ListTile(
            leading: Icon(Icons.folder,
                size: 38, color: Theme.of(context).textTheme.bodyLarge?.color),
            title: const Text(".."),
            onTap: () {
              model.onChangeDir(model.pathString.split("/")..removeLast());
            },
          );
        }
        index = index - 1;
        final item = model.list![index];
        final isDir = (model.isSelectDirMode && item is Directory);
        return ListTile(
          title: Text(
            model.getPathName(item.path),
            style: isDir
                ? null
                : TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.color
                        ?.withOpacity(.4),
                  ),
          ),
          leading: Icon(isDir ? Icons.folder : Icons.file_present_rounded,
              size: 38,
              color:
                  isDir ? Theme.of(context).textTheme.bodyLarge?.color : null),
          onTap: isDir
              ? () {
                  model.onChangeDir(item.path.split("/"));
                }
              : null,
        );
      },
      itemCount: (model.list?.length ?? 0) + 1,
    );
  }

  @override
  String getUITitle(BuildContext context, FileLocalUIModel model) =>
      "Select Path";

  @override
  PreferredSizeWidget? buildAppbar(
      BuildContext context, FileLocalUIModel model) {
    return makeAppbar(context, getUITitle(context, model),
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 24),
            child: makePathRow(context, model)),
        actions: [
          IconButton(
              tooltip: "Create New Folder",
              onPressed: model.onCreateNewFolder,
              icon: const Icon(Icons.create_new_folder))
        ]);
  }

  Widget makePathRow(BuildContext context, FileLocalUIModel model) {
    final path = model.path;
    final pathMap = path.asMap();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: fastPadding(
          all: null,
          top: 6,
          left: 12,
          right: 12,
          bottom: 6,
          child: SingleChildScrollView(
            controller: model.pathScrollCtrl,
            scrollDirection: Axis.horizontal,
            child: Text.rich(
              TextSpan(children: [
                makePathItem(
                  "/",
                  onTap: () {
                    model.onChangeDir([]);
                  },
                ),
                for (final kv in pathMap.entries)
                  makePathItem(
                    kv.value,
                    onTap: () {
                      model.onChangeDir(path.sublist(0, kv.key + 1));
                    },
                  ),
              ]),
              maxLines: 1,
              textAlign: TextAlign.start,
            ),
          )),
    );
  }

  InlineSpan makePathItem(String name, {required VoidCallback onTap}) {
    return WidgetSpan(
        child: InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 1),
          Text(name, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 1),
          const Icon(
            Icons.chevron_right_sharp,
            size: 18,
          ),
          const SizedBox(width: 1),
        ],
      ),
    ));
  }

  @override
  Widget? getBottomNavigationBar(BuildContext context, FileLocalUIModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: ElevatedButton(
            onPressed: model.onSelect,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text("Save"),
          ),
        ),
        makeSafeAre(context),
      ],
    );
  }

  static Future push(BuildContext context) async {
    return BaseUIContainer(
        uiCreate: () => FileLocalUI(),
        modelCreate: () => FileLocalUIModel()).push(context);
  }
}
