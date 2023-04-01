import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/conf.dart';

class CacheImage extends StatefulWidget {
  final String? url;
  final Widget? nullUrlWidget;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final int? cacheHeight;
  final int? cacheWidth;
  final BorderRadius? borderRadius;
  final bool clearMemoryCacheWhenDispose;

  /// loader
  final double loaderSize;

  const CacheImage(this.url,
      {super.key,
      this.loaderSize = 32,
      this.nullUrlWidget,
      this.fit,
      this.height,
      this.width,
      this.cacheHeight,
      this.cacheWidth,
      this.borderRadius,
      this.clearMemoryCacheWhenDispose = false});

  @override
  State<CacheImage> createState() => _CacheImageState();
}

class _CacheImageState extends State<CacheImage> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));

  @override
  Widget build(BuildContext context) {
    if (widget.url == null || widget.url == "") {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.nullUrlWidget,
      );
    }
    return widget.borderRadius == null
        ? getImageWidget()
        : ClipRRect(
            borderRadius: widget.borderRadius,
            child: getImageWidget(),
          );
  }

  Widget getImageWidget() {
    return ExtendedImage.network(
      widget.url ?? "",
      width: widget.width,
      height: widget.height,
      cacheWidth: widget.cacheHeight,
      cacheHeight: widget.cacheHeight,
      headers: _getHttpHeaders(),
      enableLoadState: true,
      clearMemoryCacheWhenDispose: widget.clearMemoryCacheWhenDispose,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            controller.reset();
            return SizedBox(
              width: widget.width,
              height: widget.height,
              child: Center(
                child: Icon(
                  Icons.image,
                  color: Colors.grey.withAlpha(100),
                  size: widget.loaderSize,
                ),
              ),
            );
          case LoadState.completed:
            controller.forward();
            return FadeTransition(
                opacity: controller,
                child: ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  fit: widget.fit,
                ));
          case LoadState.failed:
            controller.reset();
            return SizedBox(
              width: widget.width,
              height: widget.height,
              child: Center(
                child: Icon(
                  Icons.error,
                  color: Colors.grey.withAlpha(100),
                  size: widget.loaderSize,
                ),
              ),
            );
        }
      },
    );
  }

  Map<String, String> _getHttpHeaders() {
    Map<String, String> h = {};
    if (widget.url!
        .contains(AppAccountManager.workingAccount?.instanceUrl ?? "")) {
      h["cookie"] = AppConf.cloudreveSession;
    }
    return h;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
