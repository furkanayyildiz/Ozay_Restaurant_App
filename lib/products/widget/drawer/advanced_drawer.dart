import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class AdvancedDrawerWidget extends StatelessWidget {
  const AdvancedDrawerWidget({
    super.key,
    required this.child,
    required this.controller,
    required this.drawer,
    this.backdrop,
    this.openRatio,
    this.animationCurve,
    this.animationDuration,
    this.animateChildDecoration,
    this.rtlOpening,
    this.openScale,
    this.disabledGestures,
  });
  final Widget child;
  final Widget drawer;
  final AdvancedDrawerController controller;
  final Widget? backdrop;
  final double? openRatio;
  final Curve? animationCurve;
  final Duration? animationDuration;
  final bool? animateChildDecoration;
  final bool? rtlOpening;
  final double? openScale;
  final bool? disabledGestures;
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.tertiary.withOpacity(0.2)
            ],
          ),
        ),
      ),
      openRatio: 0.65,
      controller: controller,
      animationCurve: Curves.linearToEaseOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openScale: 0.90,
      disabledGestures: false,
      drawer: drawer,
      child: child,
    );
  }
}
