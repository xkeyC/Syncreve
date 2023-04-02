import 'package:syncreve/base/ui.dart';

import 'account_edit_ui_model.dart';

class AccountEditUI extends BaseUI<AccountEditUIModel> {
  @override
  Widget? buildBody(BuildContext context, AccountEditUIModel model) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 6),
          fastPadding(
              all: 6,
              child: Card(
                child: fastPadding(
                    all: 12,
                    child: Column(
                      children: [
                        makeUserAvatar(64, accountData: model.accountData),
                        const SizedBox(height: 12),
                        Text(
                          "${model.accountData.cloudreveSiteConfData.user?.nickname}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        makeInfoContainer(context, model),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            makeButton(context, "ReLogin",
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                onTap: model.doReLogin),
                            makeButton(context, "Logout",
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                onTap: model.doLogout),
                          ],
                        ),
                      ],
                    )),
              )),
          fastPadding(
              all: 6,
              child: Card(
                child: fastPadding(
                    all: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Alias Host",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          child: fastPadding(
                              all: null,
                              top: 2,
                              bottom: 2,
                              left: 12,
                              right: 12,
                              child: TextField(
                                controller: model.aliasHostCtrl,
                                maxLines: 6,
                                decoration: const InputDecoration(
                                    hintText:
                                        "Used to replace Instance URL when available, example:\nhttp://192.168.1.1:8888\nhttp://127.0.0.1:3322\n...",
                                    border: InputBorder.none),
                                style: const TextStyle(fontSize: 13),
                              )),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: makeButton(context, "Update Alias",
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              onTap: model.doUpdateAliasHost),
                        ),
                      ],
                    )),
              )),
        ],
      ),
    );
  }

  Widget makeButton(BuildContext context, String name,
      {Color? backgroundColor, Color? textColor, VoidCallback? onTap}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .4,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
        child: Text(
          name,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  Widget makeInfoContainer(BuildContext context, AccountEditUIModel model) {
    final account = model.accountData;
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
              makeInfoRow("ID", account.userID ?? ""),
              makeInfoRow("Username", account.userName ?? "?"),
              makeInfoRow("Instance URL", account.instanceUrl),
              makeInfoRow("Working URL", model.getWorkingUrl()!),
              makeInfoRow("Status", model.accountStatus),
            ],
          )),
    );
  }

  Widget makeInfoRow(String name, String value) {
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
          Text(value),
        ],
      ),
    );
  }

  @override
  String getUITitle(BuildContext context, AccountEditUIModel model) =>
      "Edit Account";
}
