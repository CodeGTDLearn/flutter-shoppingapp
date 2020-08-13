import 'package:get/get.dart';

import '../../core/connection/custom_dio.dart';
import 'controller/managed_products_controller.dart';
import 'repo/i_managed_products_repo.dart';
import 'repo/managed_products_repo.dart';

class ManagedProductsBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<CustomDio>(() => CustomDio());
    Get.lazyPut<IManagedProductsRepo>(() => ManagedProductsRepo());
    Get.lazyPut<ManagedProductsController>(() => ManagedProductsController());
  }
}
