import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import 'controller_neumorphic_button.dart';

class NeumorphicButton {
  Widget button({
    required int milliseconds,
    required double height,
    required double width,
    required Color downButtonShadowColor,
    required Color upButtonShadowColor,
    required Color buttonAndBackgroundColor,
    required IconData iconButton,
    required double iconSize,
    Color iconcolor = Colors.black,
    Function? onTap,
  }) {
    Get.create(() => ControllerNeumorphicButton());
    final _controller = Get.find<ControllerNeumorphicButton>();

    return GestureDetector(
      onTap: () async {
        _controller.triggerLightNeumorphicAnimation(fullCycle: true);
        Future.delayed(Duration(milliseconds: 500)).whenComplete(() {
          if (onTap != null) onTap();
        });
      },
      child: Obx(
        () => AnimatedContainer(
            child: ScaleTransition(
                scale: _controller.scaleAnimation,
                child: Icon(iconButton, size: iconSize, color: iconcolor)),
            duration: Duration(milliseconds: milliseconds),
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: buttonAndBackgroundColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: _controller.neumorphicLightIsElevatedObs.value
                    ? [
                        _upButtonShadowColor(upButtonShadowColor),
                        _downButtonShadowColor(downButtonShadowColor)
                      ]
                    : null)),
      ),
    );
  }

  BoxShadow _upButtonShadowColor(Color color) {
    return BoxShadow(
      color: color,
      offset: const Offset(4, 4),
      blurRadius: 15,
      spreadRadius: 1,
    );
  }

  BoxShadow _downButtonShadowColor(Color color) {
    return BoxShadow(
      color: color,
      offset: const Offset(-4, -4),
      blurRadius: 15,
      spreadRadius: 1,
    );
  }
}