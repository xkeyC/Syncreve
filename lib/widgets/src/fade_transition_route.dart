import 'package:flutter/material.dart';

class FadeTransitionRoute<T> extends MaterialPageRoute<T> {
  FadeTransitionRoute({
    required super.builder,
    super.settings,
  });

  @override
  Duration get transitionDuration => const Duration(milliseconds: 800);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
