import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:syncreve/base/ui.dart';
import 'package:syncreve/ui/home/home_file_ui_model.dart';

class HomeFileUI extends BaseUI<HomeFileUIModel> {
  @override
  Widget? buildBody(BuildContext context, HomeFileUIModel model) {
    return makeFileList(context, model);
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
    return fastPadding(
        all: null,
        left: 6,
        right: 6,
        top: 6,
        child: AlignedGridView.count(
          crossAxisCount: 3,
          itemCount: model.files?.objects?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final file = model.files!.objects![index];
            return Card(
              elevation: 0,
              child: InkWell(
                onTap: () {
                  model.onTapFile(file);
                },
                child: Column(
                  children: [
                    const SizedBox(height: 6),
                    Icon(
                      file.type == "dir"
                          ? Icons.folder
                          : Icons.file_present_sharp,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      size: 28,
                    ),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Text(
                        file.name ?? "<NO_NAME>",
                        style: const TextStyle(fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            );
          },
        ));
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
                onPressed: model.onChangeListStyle,
                icon: const Icon(Icons.apps)),
            IconButton(
              tooltip: "Downloads",
              onPressed: model.goDownload,
              icon: const Icon(Icons.download),
            )
          ],
          leadingWidget: IconButton(
              tooltip: "Account",
              onPressed: model.tapHome,
              icon: makeUserAvatar(28)),
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
}
