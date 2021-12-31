import 'package:get/instance_manager.dart';

import '../../../modules/overview/controller/overview_controller.dart';
import '../../../modules/overview/repo/i_overview_repo.dart';
import '../../../modules/overview/repo/overview_repo_firebase.dart';
import '../../../modules/overview/service/i_overview_service.dart';
import '../../../modules/overview/service/overview_service.dart';

class OverviewBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<IOverviewRepo>(() => OverviewRepoFirebase());
    Get.lazyPut<IOverviewService>(() => OverviewService(repo: Get.find<IOverviewRepo>()));
    Get.lazyPut<OverviewController>(
        () => OverviewController(service: Get.find<IOverviewService>()));
  }
}