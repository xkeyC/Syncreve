import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncreve/base/ui_model.dart';
import 'package:syncreve/global_ui_model.dart';

void main() {
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
    // final model = ref.watch(provider);
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text("Hello world"),
        ),
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
}
