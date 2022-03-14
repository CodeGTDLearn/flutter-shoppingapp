import 'dart:io';

import 'package:get/instance_manager.dart';

import 'core_modal_cupertino.dart';
import 'core_modal_material.dart';
import 'i_core_adaptive_modal.dart';

class CoreModalBindings extends Bindings {
  void dependencies() {
    var _isApple = Platform.isIOS || Platform.isMacOS;

    Get.lazyPut<ICoreAdaptiveModal>(
        () => _isApple ? CoreModalCupertino() : CoreModalMaterial());
  }
}