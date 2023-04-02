import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/data/app/account.dart';
import 'package:syncreve/widgets/src/cache_image.dart';
import 'dart:ui' as ui;

import '../base/ui_model.dart';

export 'src/smart_refresher.dart';

AppBar makeAppbar(BuildContext context, String title,
    {Color? backgroundColor,
    GestureTapCallback? onBack,
    List<Widget>? actions,
    Widget? titleWidget,
    Widget? backIcon,
    PreferredSizeWidget? bottom,
    bool showBack = true,
    bool centerTitle = false,
    Color? textColor,
    Widget? leadingWidget}) {
  return AppBar(
    title: titleWidget ??
        GestureDetector(
          child: Text(title),
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
    centerTitle: centerTitle,
    automaticallyImplyLeading: false,
    elevation: .1,
    bottom: bottom,
    backgroundColor: backgroundColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Theme.of(context).brightness,
      statusBarIconBrightness: getAndroidIconBrightness(context),
    ),
    actions: actions,
    shadowColor: Colors.grey,
    leading: leadingWidget ??
        (showBack
            ? InkResponse(
                onTap: onBack ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: backIcon ??
                    Icon(
                      Icons.arrow_back_ios,
                      color: textColor ??
                          Theme.of(context).appBarTheme.titleTextStyle?.color,
                      size: 20,
                    ),
              )
            : null),
  );
}

getAndroidIconBrightness(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light
      ? Brightness.dark
      : Brightness.light;
}

Widget makeLoading(
  BuildContext context, {
  double? width,
}) {
  width ??= 30;
  return Center(
    child: SizedBox(
      width: width,
      height: width,
      // child: Lottie.asset("images/lottie/loading.zip", width: width),
      child: const CircularProgressIndicator(),
    ),
  );
}

class MyEasyLoadingAnimation extends EasyLoadingAnimation {
  @override
  Widget buildWidget(Widget child, AnimationController controller,
      AlignmentGeometry alignment) {
    return Opacity(
      opacity: controller.value,
      child: Container(
        width: 128,
        height: 128,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black.withAlpha(220),
        ),
        child: const Center(
          // child: Lottie.asset("images/lottie/loading.zip"),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

Widget makeSafeAre(BuildContext context, {bool withKeyboard = true}) {
  return SafeArea(
      child: Column(
    children: [
      const SizedBox(height: 4),
      if (withKeyboard)
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        ),
    ],
  ));
}

makeSvgColor(Color color) {
  return ui.ColorFilter.mode(color, ui.BlendMode.srcIn);
}

bool isPadUI(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.width >= size.height;
}

fastPadding(
    {required double? all,
    required Widget child,
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0}) {
  return Padding(
      padding: all != null
          ? EdgeInsets.all(all)
          : EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      child: child);
}

class NoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Widget makeUserAvatar(double size, {AppAccountData? accountData}) {
  final account = accountData ?? AppAccountManager.workingAccount;
  if (account != null && account.cloudreveSiteConfData.user?.avatar == "file") {
    final url = "${account.workingUrl}/api/v3/user/avatar/${account.userID}/l";
    return CacheImage(
      url,
      key: Key(url),
      loaderSize: size,
      cacheWidth: (size * 3).toInt(),
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(1000),
    );
  } else {
    return const Icon(Icons.account_circle, size: 64);
  }
}
