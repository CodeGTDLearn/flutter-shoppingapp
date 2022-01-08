import 'package:get/instance_manager.dart';

import '../../../../modules/overview/components/overview_scaffold/ioverview_scaffold.dart';
import '../../../../modules/overview/components/overview_scaffold/staggered_scaffold.dart';

class OverviewScaffoldBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<IOverviewScaffold>(() => StaggeredScaffold());
  }
}