import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/io/cache_manager.dart';
import 'package:syncreve/global_ui_model.dart';
import 'package:syncreve/ui/home_ui.dart';
import 'package:syncreve/ui/home_ui_model.dart';
import 'package:syncreve/ui/setup/setup_ui.dart';
import 'package:syncreve/ui/setup/setup_ui_model.dart';
import 'package:syncreve/widgets/src/fade_transition_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter("Syncrever/db");
  await AppCacheManager.init(
      "${(await getTemporaryDirectory()).absolute.path}/Syncrever/cache", 1000);
  await AppAccountManager.init();

  runApp(ProviderScope(
    child: BaseUIContainer(
      uiCreate: () => SplashUI(),
      modelCreate: () => globalUIModelProvider,
    ),
  ));

  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class SplashUI extends BaseUI<AppGlobalUIModel> {
  @override
  Widget build(BuildContext context) {
    ref.watch(provider);
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 242, 241, 246),
        cardColor: Colors.white,
        cardTheme: const CardTheme(
          elevation: .2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        cardColor: const Color.fromARGB(255, 24, 24, 24),
        cardTheme: const CardTheme(
          elevation: .2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ),
      builder: EasyLoading.init(builder: (context, widget) {
        ScreenUtil.init(context);
        EasyLoading.instance.maskType = EasyLoadingMaskType.clear;
        return widget!;
      }),
      home: Scaffold(
        key: scaffoldState,
        body: const Center(
            child: Hero(
          tag: "app_logo",
          child: Icon(
            Icons.cloud_circle,
            color: Colors.indigoAccent,
            size: 168,
          ),
        )),
      ),
    );
  }

  @override
  Widget? buildBody(BuildContext context, AppGlobalUIModel model) => null;

  @override
  String getUITitle(BuildContext context, AppGlobalUIModel model) => "SplashUI";

  @override
  PreferredSizeWidget? buildAppbar(
          BuildContext context, AppGlobalUIModel model) =>
      null;

  @override
  initState() {
    super.initState();
    _initApp();
  }

  _initApp() async {
    EasyLoading.instance.customAnimation = MyEasyLoadingAnimation();
    await Future.delayed(const Duration(seconds: 2));
    _goNext();
  }

  _goNext() async {
    if (AppAccountManager.workingAccount != null) {
      // TODO check account
      BaseUIContainer(
              uiCreate: () => HomeUI(), modelCreate: () => HomeUIModel())
          .pushAndRemoveUntil(scaffoldState.currentContext!);
      return;
    }
    Navigator.pushAndRemoveUntil(scaffoldState.currentContext!,
        FadeTransitionRoute(builder: (BuildContext context) {
      return BaseUIContainer(
          uiCreate: () => SetupUI(), modelCreate: () => SetupUIModel());
    }), (_) => false);
  }
}
