import 'package:get/get.dart';

import 'managed_products_controller.dart';

class ManagedProductsBindings extends Bindings {
  void dependencies() {
//    Get.lazyPut<IManagedProductsService>(() => ManagedProductsService());
    Get.lazyPut<ManagedProductsController>(() => ManagedProductsController());
  }
}
