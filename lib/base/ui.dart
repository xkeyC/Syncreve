import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'ui_model.dart';

export 'base_utils.dart';
export 'package:flutter/material.dart';
export '../widgets/widgets.dart';

class BaseUIContainer extends ConsumerStatefulWidget {
  final ConsumerState<BaseUIContainer> Function() uiCreate;
  final dynamic Function() modelCreate;

  const BaseUIContainer(
      {Key? key, required this.uiCreate, required this.modelCreate})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  ConsumerState<BaseUIContainer> createState() => uiCreate();

  Future push(BuildContext context) {
    return Navigator.push(context, makeRoute(context, this));
  }

  /// 获取路由
  MaterialPageRoute makeRoute(
      BuildContext context, BaseUIContainer baseUIContainer) {
    return MaterialPageRoute(builder: (BuildContext context) {
      return baseUIContainer;
    });
  }

  Future pushAndRemoveUntil(BuildContext context) {
    return Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return this;
    }), (_) => false);
  }
}

abstract class BaseUI<T extends BaseUIModel>
    extends ConsumerState<BaseUIContainer> {
  BaseUIModel? _needDisposeModel;
  late final ChangeNotifierProvider<T> provider = bindUIModel();

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  RefreshController? refreshController;

  @override
  Widget build(BuildContext context) {
    // get model
    final model = ref.watch(provider);
    return Scaffold(
      key: scaffoldState,
      appBar: buildAppbar(context, model),
      drawer: getDrawer(context, model),
      drawerEnableOpenDragGesture:
          getDrawerEnableOpenDragGesture(context, model),
      backgroundColor: getBackgroundColor(context, model),
      body: errorBody(context, buildBody(context, model), model),
      bottomNavigationBar: getBottomNavigationBar(context, model),
      floatingActionButton: getFloatingActionButton(context, model),
      floatingActionButtonLocation:
          getFloatingActionButtonLocation(context, model),
    );
  }

  String getUITitle(BuildContext context, T model);

  Widget? buildBody(
    BuildContext context,
    T model,
  );

  Widget? getBottomNavigationBar(BuildContext context, T model) => null;

  Color? getBackgroundColor(BuildContext context, T model) => null;

  Widget? getFloatingActionButton(BuildContext context, T model) => null;

  FloatingActionButtonLocation? getFloatingActionButtonLocation(
          BuildContext context, T model) =>
      null;

  bool getDrawerEnableOpenDragGesture(BuildContext context, T model) => true;

  Widget? getDrawer(BuildContext context, T model) => null;

  PreferredSizeWidget? buildAppbar(BuildContext context, T model) {
    return makeAppbar(context, getUITitle(context, model));
  }

  @mustCallSuper
  @override
  void initState() {
    dPrint("[base] <$runtimeType> UI Init");
    super.initState();
  }

  @mustCallSuper
  @override
  void dispose() {
    dPrint("[base] <$runtimeType> UI Disposed");
    _needDisposeModel?.dispose();
    _needDisposeModel = null;
    super.dispose();
  }

  /// 关闭键盘
  dismissKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Widget errorBody(BuildContext context, Widget? child, T model) {
    if (model.uiErrorMsg.isNotEmpty) {
      // 全局错误信息
      return InkWell(
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Error",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(model.uiErrorMsg),
          ],
        )),
        onTap: () async {
          await model.reloadData();
        },
      );
    }
    if (child == null) return makeLoading(context);
    return child;
  }

  void updateStatusBarIconColor(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Theme.of(context).brightness,
      statusBarIconBrightness: getAndroidIconBrightness(context),
    ));
  }

  ChangeNotifierProvider<T> bindUIModel() {
    final createdModel = widget.modelCreate();
    if (createdModel is T) {
      _needDisposeModel = createdModel;
      return ChangeNotifierProvider<T>((ref) {
        return createdModel..context = context;
      });
    }
    return createdModel;
  }

  Widget pullToRefreshBody(
      {required BaseUIModel model, required Widget child}) {
    refreshController ??= RefreshController();
    return AppSmartRefresher(
      enablePullUp: false,
      controller: refreshController,
      onRefresh: () async {
        await model.reloadData();
        refreshController?.refreshCompleted();
      },
      child: child,
    );
  }
}
