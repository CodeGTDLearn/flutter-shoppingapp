import 'package:get/get.dart';

import '../../managed_products/managed_products_controller.dart';
import '../../managed_products/services/i_managed_products_service.dart';
import '../../managed_products/services/managed_products_service.dart';
import '../../overview/repo/i_overview_repo.dart';
import '../../overview/repo/overview_firebase_repo.dart';

class ManagedProducts {
  static void dependencies() {
    Get.lazyPut<IOverviewRepo>(() => OverviewFirebaseRepo());
    Get.lazyPut<IManagedProductsService>(() => ManagedProductsService());
    Get.lazyPut<ManagedProductsController>(() => ManagedProductsController());
  }
}
