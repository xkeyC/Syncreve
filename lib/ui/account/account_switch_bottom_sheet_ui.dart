import 'package:syncreve/base/ui.dart';
import 'package:syncreve/common/account_manager.dart';

import 'account_switch_bottom_sheet_ui_model.dart';

class AccountSwitchBottomSheetUI
    extends BaseUI<AccountSwitchBottomSheetUIModel> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(provider);
    return SizedBox(
      height: model.accounts == null
          ? MediaQuery.of(context).size.height * .8
          : null,
      child: getList(context, model),
    );
  }

  Widget? getList(BuildContext context, AccountSwitchBottomSheetUIModel model) {
    if (model.accounts == null) return makeLoading(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: ListView.builder(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 0),
          shrinkWrap: true,
          itemCount: (model.accounts?.length ?? 0) + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == model.accounts?.length) {
              return Column(
                children: [
                  Card(
                    child: InkWell(
                      child: fastPadding(
                          all: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add),
                              SizedBox(width: 32),
                              Text("New Account"),
                            ],
                          )),
                      onTap: model.onNewAccount,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              );
            }
            final account = model.accounts![index];
            final accountChecked = model.checkAccount[account.id];
            return Card(
              color: account.id == AppAccountManager.workingAccount?.id
                  ? Colors.purpleAccent.withAlpha(10)
                  : null,
              child: InkWell(
                onTap: () {
                  model.onSelectAccount(account);
                },
                child: fastPadding(
                    all: 12,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 100),
                              child: Container(
                                key: Key(
                                    "AccountSwitchBottomSheetUI_Container_$accountChecked"),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  color: (accountChecked == null
                                      ? null
                                      : (accountChecked
                                          ? Colors.green
                                          : Colors.red)),
                                ),
                                child: accountChecked == null
                                    ? makeLoading(context, width: 6)
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            makeUserAvatar(48, accountData: account),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${account.cloudreveSiteConfData.title}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${account.instanceUrl} -> ${account.userName}",
                                      style: TextStyle(
                                          fontSize: 10.3,
                                          color: Theme.of(context)
                                              .unselectedWidgetColor),
                                    ),
                                  ],
                                )
                              ],
                            )),
                            InkResponse(
                              onTap: () {
                                model.goEdit(account);
                              },
                              child: const Icon(Icons.edit),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            );
          }),
    );
  }

  @override
  Widget? buildBody(
          BuildContext context, AccountSwitchBottomSheetUIModel model) =>
      null;

  @override
  String getUITitle(
          BuildContext context, AccountSwitchBottomSheetUIModel model) =>
      "";
}
