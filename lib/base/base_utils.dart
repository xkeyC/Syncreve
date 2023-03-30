import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:fluttertoast/fluttertoast.dart';

void dPrint(src) {
  if (kDebugMode) {
    print(src);
  }
}

void showToast(String msg,
    {Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.CENTER}) {
  Fluttertoast.showToast(msg: msg, toastLength: toastLength, gravity: gravity);
}

bool stringIsNotEmpty(String? s) {
  return s != null && (s.isNotEmpty);
}

Future<Uint8List?> widgetToPngImage(GlobalKey repaintBoundaryKey,
    {double pixelRatio = 3.0}) async {
  RenderRepaintBoundary? boundary = repaintBoundaryKey.currentContext
      ?.findRenderObject() as RenderRepaintBoundary?;
  if (boundary == null) return null;

  ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  if (byteData == null) return null;
  var pngBytes = byteData.buffer.asUint8List();
  return pngBytes;
}

double roundDoubleTo(double value, double precision) =>
    (value * precision).round() / precision;
