import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncreve/common/io/cache_manager.dart';

class CacheImage extends StatefulWidget {
  final String? url;
  final Widget? nullUrlWidget;

  /// loader
  final double loaderSize;

  const CacheImage(this.url,
      {super.key, this.loaderSize = 64, this.nullUrlWidget});

  @override
  State<CacheImage> createState() => _CacheImageState();
}

class _CacheImageState extends State<CacheImage>
    with AutomaticKeepAliveClientMixin {
  File? imageFile;
  bool isLoadingFailed = false;
  String curUrl = "";

  _loadImage() async {
    if (curUrl == widget.url) return;
    if (widget.url == null || widget.url == "") {
      return;
    }
    curUrl = widget.url!;
    try {
      final file = await AppCacheManager.getFile(curUrl);
      setState(() {
        imageFile = file;
      });
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 16));
      setState(() {
        isLoadingFailed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _loadImage();
    if (widget.url == null || widget.url == "") {
      if (widget.nullUrlWidget != null) {
        return widget.nullUrlWidget!;
      }
      return const SizedBox();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: imageFile == null
          ? Icon(
              isLoadingFailed ? Icons.error_outlined : Icons.image,
              size: widget.loaderSize,
              color: Colors.grey,
            )
          : Image.file(imageFile!),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
