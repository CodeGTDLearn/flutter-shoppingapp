import 'package:get/instance_manager.dart';

import '../../../../core/components/core_components_keys.dart';
import '../../../../core/components/drawer/core_drawer_labels.dart';
import '../../../../core/texts/core_labels.dart';
import '../../../../core/texts/core_messages.dart';
import '../../../../modules/overview/controller/overview_controller.dart';
import '../../../../modules/overview/repo/i_overview_repo.dart';
import '../../../../modules/overview/repo/overview_repo_http_firebase.dart';
import '../../../../modules/overview/service/i_overview_service.dart';
import '../../../../modules/overview/service/overview_service.dart';
import '../overview_icons.dart';
import '../overview_labels.dart';

class OverviewBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => CoreLabels());
    Get.lazyPut(() => CoreMessages());
    Get.lazyPut(() => CoreComponentsKeys());
    Get.lazyPut(() => CoreDrawerLabels());

    Get.lazyPut(() => OverviewIcons());
    Get.lazyPut(() => OverviewLabels());
    Get.lazyPut<IOverviewRepo>(() => OverviewRepoHttpFirebase());
    Get.lazyPut<IOverviewService>(() => OverviewService(repo: Get.find<IOverviewRepo>()));
    Get.lazyPut(() => OverviewController(service: Get.find<IOverviewService>()));
  }
}