import 'package:flutter/material.dart';

abstract class PageAnimation {
  static PageRouteBuilder<dynamic> animatedPageRoute(
      RouteSettings settings, Widget screen) {
    return PageRouteBuilder(
      settings:
          settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
