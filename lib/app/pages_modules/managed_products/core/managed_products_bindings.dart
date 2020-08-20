import 'package:get/get.dart';

import '../controller/managed_products_controller.dart';
import '../repo/i_managed_products_repo.dart';
import '../repo/managed_products_firebase_repo.dart';
import '../service/i_managed_products_service.dart';
import '../service/managed_products_service.dart';

class ManagedProductsBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<IManagedProductsRepo>(() => ManagedProductsRepo());
    Get.lazyPut<IManagedProductsService>(() => ManagedProductsService());
    Get.lazyPut<ManagedProductsController>(() => ManagedProductsController());
  }
}
