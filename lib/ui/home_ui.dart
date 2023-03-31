import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncreve/base/ui.dart';
import 'package:syncreve/ui/home/home_account_ui.dart';
import 'package:syncreve/ui/home/home_account_ui_model.dart';
import 'package:syncreve/ui/home/home_file_ui.dart';
import 'package:syncreve/ui/home/home_file_ui_model.dart';
import 'package:syncreve/ui/home/home_sync_ui.dart';
import 'package:syncreve/ui/home/home_sync_ui_model.dart';
import 'package:syncreve/ui/home_ui_model.dart';

class HomeUI extends BaseUI<HomeUIModel> with SingleTickerProviderStateMixin {
  late final tabCtrl = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(provider);
    return isPadUI(context)
        ? makePadUI(context, model)
        : makePhoneUI(context, model);
  }

  Widget makePhoneUI(BuildContext context, HomeUIModel model) {
    return Scaffold(
      body: makeTabPageView(context, model),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabCtrl.index,
        iconSize: 20,
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.cloud), label: "File"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.arrowsRotate), label: "Sync"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user), label: "Account"),
        ],
        onTap: onChangePageIndex,
      ),
    );
  }

  Widget makePadUI(BuildContext context, HomeUIModel model) {
    return Container();
  }

  void onChangePageIndex(int value) {
    tabCtrl.index = value;
    setState(() {});
  }

  Widget makeTabPageView(BuildContext context, HomeUIModel model) {
    return TabBarView(
      controller: tabCtrl,
      physics: const NeverScrollableScrollPhysics(),
      children: getChildPages(context, model),
    );
  }

  List<Widget> getChildPages(BuildContext context, HomeUIModel model) {
    return [
      BaseUIContainer(
          uiCreate: () => HomeFileUI(),
          modelCreate: () =>
              model.getChildUIModelProviders<HomeFileUIModel>("file")),
      BaseUIContainer(
          uiCreate: () => HomeSyncUI(),
          modelCreate: () =>
              model.getChildUIModelProviders<HomeSyncUIModel>("sync")),
      BaseUIContainer(
          uiCreate: () => HomeAccountUI(),
          modelCreate: () =>
              model.getChildUIModelProviders<HomeAccountUIModel>("account")),
    ];
  }

  @override
  Widget? buildBody(BuildContext context, HomeUIModel model) => null;

  @override
  String getUITitle(BuildContext context, HomeUIModel model) => "Syncreve Home";

  @override
  PreferredSizeWidget? buildAppbar(BuildContext context, HomeUIModel model) =>
      null;
}
