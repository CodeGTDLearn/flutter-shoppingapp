import 'package:get/instance_manager.dart';

import '../controller/overview_controller.dart';
import '../repo/i_overview_repo.dart';
import '../repo/overview_repo_firebase.dart';
import '../service/i_overview_service.dart';
import '../service/overview_service.dart';

class OverviewBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<IOverviewRepo>(() => OverviewRepoFirebase());
    Get.lazyPut<IOverviewService>(() => OverviewService(repo: Get.find<IOverviewRepo>()));
    Get.lazyPut<OverviewController>(
        () => OverviewController(service: Get.find<IOverviewService>()));
  }
}