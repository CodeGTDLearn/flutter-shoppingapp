import 'package:get/instance_manager.dart';

import '../../../../modules/overview/controller/overview_controller.dart';
import '../../../../modules/overview/repo/i_overview_repo.dart';
import '../../../../modules/overview/repo/overview_repo_firebase.dart';
import '../../../../modules/overview/service/i_overview_service.dart';
import '../../../../modules/overview/service/overview_service.dart';
import '../../../icons/modules/overview_icons.dart';
import '../../../keys/global_widgets_keys.dart';
import '../../../labels/global_labels.dart';
import '../../../labels/global_widgets_labels.dart';
import '../../../labels/message_labels.dart';
import '../../../labels/modules/overview_labels.dart';

class OverviewBindings extends Bindings {
  void dependencies() {
    Get.lazyPut(() => GlobalLabels());
    Get.lazyPut(() => OverviewIcons());
    Get.lazyPut(() => MessageLabels());
    Get.lazyPut(() => OverviewLabels());
    Get.lazyPut(() => GlobalWidgetsKeys());
    Get.lazyPut(() => GlobalWidgetsLabels());
    Get.lazyPut<IOverviewRepo>(() => OverviewRepoFirebase());
    Get.lazyPut<IOverviewService>(() => OverviewService(repo: Get.find<IOverviewRepo>()));
    Get.lazyPut(() => OverviewController(service: Get.find<IOverviewService>()));
  }
}