import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/conf.dart';
import 'package:syncreve/global_ui_model.dart';
import 'package:syncreve/ui/home_ui.dart';
import 'package:syncreve/ui/setup/setup_ui.dart';

import 'common/grpc/grpc_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConf.init();

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
      title: "Syncreve",
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
        EasyLoading.instance.customAnimation = MyEasyLoadingAnimation();
        EasyLoading.instance.animationStyle = EasyLoadingAnimationStyle.custom;
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
    await Future.delayed(const Duration(seconds: 1));
    await AppGRPCManager.pingServer();
    if (!AppGRPCManager.isConnected) {
      showToast("Syncrever Service Error");
    }
    _goNext();
  }

  _goNext() async {
    if (AppAccountManager.workingAccount != null) {
      HomeUI.pushAndRemove(scaffoldState.currentContext!);
      return;
    }
    SetupUI.pushAndRemove(scaffoldState.currentContext!);
  }
}
