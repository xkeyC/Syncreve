import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../widgets.dart';

class AppSmartRefresher extends StatelessWidget {
  final Widget? child;
  final RefreshController? controller;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final bool enablePullDown;
  final bool enablePullUp;

  const AppSmartRefresher({
    super.key,
    this.child,
    this.controller,
    this.onRefresh,
    this.onLoading,
    this.enablePullDown = true,
    this.enablePullUp = true,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      // header: WaterDropHeader(),
      header: ClassicHeader(
        releaseText: '',
        refreshingText: '',
        completeText: '',
        failedText: '',
        idleText: '',
        refreshingIcon: makeLoading(context),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("");
          } else {
            body = const Text("");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: controller!,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: child,
    );
  }
}
