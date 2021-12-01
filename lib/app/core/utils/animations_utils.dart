import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

// ignore: avoid_classes_with_only_static_members
class AnimationsUtils {
  //Instruction: https://www.youtube.com/watch?v=3GMq45zRVLo
  Widget zoomPageTransitionSwitcher({
    required RxBool zoomObservable,
    int milliseconds = 375,
    Color fillColor = Colors.white,
    String title = "",
    required String imageUrl,
    required Function zoomToggleMethod,
    //closeBuilder: Starting/Origin Widget that will be zoomed
    required Widget closeBuilder,
  }) {
    return Obx(
      () => PageTransitionSwitcher(
        duration: Duration(milliseconds: milliseconds),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return SharedAxisTransition(
              child: child,
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
              fillColor: fillColor);
        },
        child: zoomObservable.value
            ? GestureDetector(
                onTap: () => zoomToggleMethod.call(),
                child: InteractiveViewer(
                    minScale: 0.2,
                    maxScale: 100.2,
                    child: Image.network(imageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover)))
            : closeBuilder,
      ),
    );
  }
}