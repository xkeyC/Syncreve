import 'dart:ui';

import 'package:flutter/material.dart';

class BlurOvalWidget extends StatelessWidget {
  final Widget child;
  final double padding;
  final Color blurColor;
  final BorderRadius borderRadius;

  const BlurOvalWidget(
      {super.key,
      required this.child,
      this.padding = 0,
      this.blurColor = Colors.white10,
      this.borderRadius = BorderRadius.zero});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          color: blurColor,
          child: child,
        ),
      ),
    );
  }
}
