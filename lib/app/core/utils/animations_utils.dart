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
    required Function observableToggleMethod,
    //closeBuilder: Starting/Origin Widget that will be zoomed
    required Widget closeBuilder,
    bool reverse = false,
  }) {
    return Obx(() => PageTransitionSwitcher(
        reverse: reverse,
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
            ? _zoomingGestureDetector(observableToggleMethod, imageUrl)

            /*╔═══════════════════════════════════════════════════════════════╗
              ║  !!!ATTENTION!!! <<==== GestureDetector =====>> closeBuilder  ║
              ╠═══════════════════════════════════════════════════════════════╣
              ║    INSIDE THE CLOSED-BUILDER-WIDGET(closeBuilder) MUST HAVE   ║
              ║        A  GestureDetector WITH observableToggleMethod         ║
              ║               THAT WILL START THIS ANIMATION                  ║
              ╚═══════════════════════════════════════════════════════════════╝*/
            : closeBuilder));
  }

  GestureDetector _zoomingGestureDetector(
    Function observableToggleMethod,
    String imageUrl,
  ) {
    return GestureDetector(
        onTap: () => observableToggleMethod.call(),
        child: InteractiveViewer(
            minScale: 0.2,
            maxScale: 100.2,
            child: Image.network(
              imageUrl,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            )));
  }

  OpenContainer<Object> openContainer({
    required Widget closingWidget,
    Function? closingFunction,
    required Widget openingWidget,
    int milliseconds = 375,
    int closedElevation = 0,
    transitionType = ContainerTransitionType.fadeThrough,
  }) {
    return OpenContainer(
        transitionDuration: Duration(milliseconds: milliseconds),
        transitionType: ContainerTransitionType.fadeThrough,
        closedElevation: 0,

        //openingWidget / openBuilder: Widget that will be close/minimized
        openBuilder: (context, void Function({Object? returnValue}) action) {
          return openingWidget;
        },

        //closingWidget / closedBuilder: Widget that will be opened
        closedBuilder: (context, void Function() openContainer) {
          return GestureDetector(
            onTap: () {
              closingFunction?.call();
              openContainer.call();
            },
            child: (closingWidget),
          );
        });
  }
}