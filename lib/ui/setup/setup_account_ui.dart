import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/data/site/cloudreve_site_conf_data.dart';
import 'package:syncreve/widgets/src/cache_image.dart';
import 'setup_account_ui_model.dart';

class SetupAccountUI extends BaseUI<SetupAccountUIModel> {
  @override
  Widget? buildBody(BuildContext context, SetupAccountUIModel model) {
    final data = model.cloudreveSiteConfData;
    if (data == null) return null;
    return fastPadding(
        all: 6,
        child: Column(
          children: [
            const SizedBox(height: 32),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: fastPadding(
                    all: 12,
                    child: Column(
                      children: [
                        if (data.user?.avatar == "file")
                          ClipOval(
                            child: SizedBox(
                                width: 64,
                                height: 64,
                                child: CacheImage(
                                  "${model.workingUrl}/api/v3/user/avatar/${data.user?.id}/l",
                                  loaderSize: 64,
                                )),
                          )
                        else
                          const Icon(Icons.account_circle, size: 64),
                        const SizedBox(height: 6),
                        Text(
                          "${data.user?.nickname}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 12),
                        makeInfoContainer(context, model, data),
                        const SizedBox(height: 12),
                      ],
                    )),
              ),
            ),
            const SizedBox(height: 32),
            FloatingActionButton(
              onPressed: model.checkAccount,
              child: const Icon(Icons.check),
            )
          ],
        ));
  }

  Widget makeInfoContainer(BuildContext context, SetupAccountUIModel model,
      CloudreveSiteConfData data) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: fastPadding(
          all: null,
          top: 8,
          bottom: 8,
          left: 18,
          right: 18,
          child: Column(
            children: [
              makeInfoRow("ID", data.user?.id ?? "?"),
              makeInfoRow("Username", data.user?.userName ?? "?"),
              makeInfoRow("Status", "${data.user?.status}"),
              makeInfoRow("Avatar", "${data.user?.avatar}"),
              makeInfoRow("Group",
                  "${data.user?.group?.name} (${data.user?.group?.id})"),
              makeInfoRow("Webdav", "${data.user?.group?.webdav}"),
              makeInfoRow("AllowShare", "${data.user?.group?.allowShare}"),
              makeInfoRow("Compress", "${data.user?.group?.compress}"),
              makeInfoRow(
                  "ShareDownload", "${data.user?.group?.shareDownload}"),
              makeInfoRow("AllowArchiveDownload",
                  "${data.user?.group?.allowArchiveDownload}"),
              makeInfoRow("AllowRemoteDownload",
                  "${data.user?.group?.allowRemoteDownload}"),
              makeInfoRow(
                  "AdvanceDelete", "${data.user?.group?.advanceDelete}"),
              makeInfoRow("SourceBatch", "${data.user?.group?.sourceBatch}"),
              makeInfoRow("Cloudreve Instance URL", model.workingUrl),
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
  String getUITitle(BuildContext context, SetupAccountUIModel model) =>
      "Account setup";

  @override
  PreferredSizeWidget? buildAppbar(
      BuildContext context, SetupAccountUIModel model) {
    return makeAppbar(context, getUITitle(context, model), onBack: () {});
  }
}
