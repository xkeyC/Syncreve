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
  StreamSubscription? fileStream;

  @override
  void initState() {
    if (fileStream != null || widget.url == null || widget.url == "") {
      return;
    }
    fileStream =
        AppCacheManager.getFile(widget.url!)!.asStream().listen((file) {
      setState(() {
        imageFile = file;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    if (fileStream != null) {
      fileStream!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.url == null || widget.url == "") {
      if (widget.nullUrlWidget != null) {
        return widget.nullUrlWidget!;
      }
      return const SizedBox();
    }

    return imageFile == null
        ? Icon(
            Icons.image,
            size: widget.loaderSize,
            color: Colors.grey,
          )
        : Image.file(imageFile!);
  }

  @override
  bool get wantKeepAlive => true;
}
