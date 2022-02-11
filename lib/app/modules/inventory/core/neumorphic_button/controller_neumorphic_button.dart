import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class ControllerNeumorphicButton extends GetxController with GetSingleTickerProviderStateMixin {
  //SCALE-ADJUSTMENTS
  late AnimationController _scaleController;
  late Animation<double> scaleAnimation;
  var _end = 0.97;
  var _begin = 1.0;

  //NEUMORPHIC-LIGHT
  var neumorphicLightIsElevatedObs = true.obs;

  @override
  void onInit() {
    super.onInit();
    _scaleAnimationSetup();
  }

  @override
  void dispose() {
    super.dispose();
    _scaleController.dispose();
  }

  void triggerLightNeumorphicAnimation({required bool fullCycle}) async {
    scalePlayAnimation(forward: true);
    neumorphicLightIsElevatedObs.value = !neumorphicLightIsElevatedObs.value;
    if (fullCycle) {
      await Future.delayed(Duration(milliseconds: 500));
      scalePlayAnimation(forward: false);
      neumorphicLightIsElevatedObs.value = !neumorphicLightIsElevatedObs.value;
    }
  }

  void _scaleAnimationSetup() {
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 225),
      vsync: this,
      value: 1.0,
    );

    // scaleAnimation = CurvedAnimation(parent: _scaleController, curve: Curves.bounceInOut);
    scaleAnimation = Tween(
      begin: _begin,
      end: _end,
    ).animate(CurvedAnimation(parent: _scaleController, curve: Curves.easeIn));
  }

  void scalePlayAnimation({required bool forward}) async {
    if (forward) await _scaleController.forward();
    if (!forward) await _scaleController.reverse();
  }
}