import 'package:filesize/filesize.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncreve/base/ui.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/utils/string.dart';
import 'package:syncreve/data/file/cloudreve_file_data.dart';
import 'package:syncreve/ui/home/home_file_ui_model.dart';
import 'package:syncreve/widgets/src/blur_oval_widget.dart';
import 'package:syncreve/widgets/src/cache_image.dart';

class HomeFileUI extends BaseUI<HomeFileUIModel> {
  @override
  Widget? buildBody(BuildContext context, HomeFileUIModel model) {
    return WillPopScope(
        onWillPop: model.willPop,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: Stack(
            children: [
              makeFileList(context, model),
              if (model.isInSelectMode)
                Positioned(
                    bottom: 0, child: makeFileBottomMenus(context, model))
            ],
          ),
        ));
  }

  Widget makePathRow(BuildContext context, HomeFileUIModel model) {
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
          const SizedBox(width: 4),
          Text(name, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 2),
          const Icon(
            Icons.chevron_right_sharp,
            size: 18,
          ),
          const SizedBox(width: 4),
        ],
      ),
    ));
  }

  Widget makeFileList(BuildContext context, HomeFileUIModel model) {
    if (model.files == null) return makeLoading(context);
    double cardWidth = 0;

    if (model.isCardFileList) {
      cardWidth = (MediaQuery.of(context).size.width / 3) - 11;
    }
    return fastPadding(
        all: null,
        left: 6,
        right: 6,
        top: 0,
        child: RefreshIndicator(
            onRefresh: () {
              return model.reloadData(skipClean: true);
            },
            child: AlignedGridView.count(
              crossAxisCount: model.isCardFileList ? 3 : 1,
              cacheExtent: 20,
              itemCount: model.files?.objects?.length ?? 0,
              padding: EdgeInsets.only(
                  top: 6, bottom: model.isInSelectMode ? 64 : 0),
              itemBuilder: (BuildContext context, int index) {
                final file = model.files!.objects![index];
                final isPic = file.pic?.isNotEmpty ?? false;
                return model.isCardFileList
                    ? makeCardItem(context, model, file, isPic, cardWidth)
                    : makeListItem(context, model, file, isPic);
              },
            )));
  }

  Widget makeCardItem(BuildContext context, HomeFileUIModel model,
      CloudreveFileObjectsData file, bool isPic, double widgetWidth) {
    final isSelected = model.isFileSelected(file);
    return ExcludeSemantics(
        child: Padding(
      padding: const EdgeInsets.all(5.5),
      child: InkWell(
          onTap: () {
            if (model.isInSelectMode) {
              model.onSelected(file);
              return;
            }
            model.onTapFile(file);
          },
          onLongPress: () {
            model.onSelected(file);
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SizedBox(height: isPic ? 0 : 6),
                    makeFileIcon(
                        isPic: isPic,
                        width: widgetWidth,
                        height: 90,
                        file: file,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12)),
                        iconSize: 42,
                        model: model),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text(
                        file.name ?? "<NO_NAME>",
                        style: const TextStyle(fontSize: 12),
                        maxLines: isPic ? 1 : 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
              if (model.isInSelectMode)
                Positioned(
                    top: 8,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor.withAlpha(150),
                          borderRadius: BorderRadius.circular(1000)),
                      child: Center(
                        child: Icon(
                          isSelected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          size: 18,
                        ),
                      ),
                    ))
            ],
          )),
    ));
  }

  Widget makeListItem(BuildContext context, HomeFileUIModel model,
      CloudreveFileObjectsData file, bool isPic) {
    final isSelected = model.isFileSelected(file);
    return Card(
      elevation: .1,
      child: fastPadding(
          all: 6,
          child: InkWell(
            onTap: () {
              if (model.isInSelectMode) {
                model.onSelected(file);
                return;
              }
              model.onTapFile(file);
            },
            onLongPress: () {
              model.onSelected(file);
            },
            child: Row(
              children: [
                makeFileIcon(
                    isPic: isPic,
                    width: 48,
                    height: 48,
                    file: file,
                    borderRadius: BorderRadius.circular(7),
                    iconSize: 24,
                    model: model),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          file.name ?? "",
                          style: const TextStyle(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${StringUtil.getTimeDateString(file.date!)}    ${(file.size != null && file.size != 0) ? filesize(file.size) : ""}",
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).unselectedWidgetColor,
                      ),
                    ),
                  ],
                )),
                if (model.isInSelectMode)
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Icon(
                      isSelected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      size: 18,
                    ),
                  )
              ],
            ),
          )),
    );
  }

  Widget makeFileIcon(
      {required bool isPic,
      required double width,
      required double height,
      required CloudreveFileObjectsData file,
      required BorderRadius borderRadius,
      required double iconSize,
      required HomeFileUIModel model}) {
    var c = isPic
        ? CacheImage(
            "${AppAccountManager.workingAccount?.workingUrl}/api/v3/file/thumb/${file.id}",
            loaderSize: width / 2,
            fit: BoxFit.cover,
            height: height,
            width: width,
            cacheWidth: width.toInt() * 3,
            borderRadius: borderRadius,
          )
        : fastPadding(
            all: 6,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Icon(
                  file.type == "dir"
                      ? Icons.folder
                      : FontAwesomeIcons.solidFile,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  size: iconSize,
                ),
              ),
            ));

    return SizedBox(
      width: width,
      height: height,
      child: c,
    );
  }

  @override
  String getUITitle(BuildContext context, HomeFileUIModel model) => "";

  @override
  PreferredSizeWidget? buildAppbar(
          BuildContext context, HomeFileUIModel model) =>
      makeAppbar(context, "",
          titleWidget: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: makeSearchBar(context, model),
          ),
          actions: [
            IconButton(
                tooltip: "Change List Style",
                onPressed: model.onChangeListStyle,
                icon: Icon(
                    model.isCardFileList ? Icons.apps : Icons.list_alt_sharp)),
            IconButton(
              tooltip: "Downloads",
              onPressed: model.goDownload,
              icon: const Icon(Icons.download),
            )
          ],
          leadingWidget: IconButton(
              tooltip: "Account",
              onPressed: model.onTapAvatar,
              icon: Hero(
                tag: "app_logo",
                child: makeUserAvatar(28),
              )),
          bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 24),
              child: makePathRow(context, model)),
          showBack: false);

  Widget makeSearchBar(BuildContext context, HomeFileUIModel model) {
    return fastPadding(
        all: 6,
        child: Center(
          child: Row(
            children: [
              const SizedBox(width: 3),
              Icon(Icons.search,
                  size: 16, color: Theme.of(context).unselectedWidgetColor),
              const SizedBox(width: 6),
              Text(
                "Search file ...",
                style: TextStyle(
                    color: Theme.of(context).unselectedWidgetColor,
                    fontSize: 13),
              )
            ],
          ),
        ));
  }

  Widget makeFileBottomMenus(BuildContext context, HomeFileUIModel model) {
    final menus = [
      _FileBottomMenu("more", "More", Icons.more_horiz),
      _FileBottomMenu("sync", "Sync", Icons.sync),
      _FileBottomMenu("delete", "Delete", Icons.delete),
      _FileBottomMenu("share", "Share", Icons.share),
      _FileBottomMenu("download", "Download", Icons.download_outlined),
    ];

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 54,
        child: Container(
          color: Colors.transparent,
          margin: const EdgeInsets.only(left: 6, right: 6, bottom: 4),
          child: BlurOvalWidget(
              borderRadius: BorderRadius.circular(7),
              blurColor: Colors.white54,
              child: Material(
                color: Colors.transparent,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      makeMenuButton(Icons.close_rounded, "Close", () {
                        model.selectedFiles.clear();
                        model.notifyListeners();
                      }),
                      Container(
                        width: .3,
                        height: 24,
                        color: Theme.of(context).unselectedWidgetColor,
                      ),
                      for (final m in menus)
                        makeMenuButton(m.icon, m.name, () {}),
                    ],
                  ),
                ),
              )),
        ));
  }
}

Widget makeMenuButton(IconData icon, String name, GestureTapCallback? onTap) {
  return SizedBox(
    width: 64,
    child: InkResponse(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          const SizedBox(
            height: 1,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 9),
          ),
        ],
      ),
    ),
  );
}

class _FileBottomMenu {
  String actionKey;
  String name;
  IconData icon;

  _FileBottomMenu(this.actionKey, this.name, this.icon);
}
