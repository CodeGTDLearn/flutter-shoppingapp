import 'package:get/instance_manager.dart';

import 'local_storage_controller.dart';

class LocalStorageBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => LocalStorageController());
  }
}