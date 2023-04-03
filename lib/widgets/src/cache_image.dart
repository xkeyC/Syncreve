import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:syncreve/base/base_utils.dart';
import 'package:syncreve/common/account_manager.dart';

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
  AnimationController? controller;

  String? urlCookies;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.url == null || widget.url == "") {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: widget.nullUrlWidget,
      );
    }
    _updateImageCookies();

    return widget.borderRadius == null
        ? getImageWidget()
        : ClipRRect(
            borderRadius: widget.borderRadius,
            child: getImageWidget(),
          );
  }

  Widget getImageWidget() {
    if (urlCookies == null) return makeLoadingWidget();
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
            controller?.reset();
            return makeLoadingWidget();
          case LoadState.completed:
            controller?.forward();
            return FadeTransition(
                opacity: controller!,
                child: ExtendedRawImage(
                  image: state.extendedImageInfo?.image,
                  fit: widget.fit,
                ));
          case LoadState.failed:
            dPrint(
                "[CacheImage] loading Error url == ${widget.url}  error == ${state.lastException}");
            controller?.reset();
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
    h["cookie"] = urlCookies ?? "";
    return h;
  }

  Widget makeLoadingWidget() {
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
  }

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    super.dispose();
  }

  void _updateImageCookies() async {
    urlCookies = await AppAccountManager.getUrlCookie(widget.url!);
    if (!mounted) return;
    setState(() {});
  }
}
