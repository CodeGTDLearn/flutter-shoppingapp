import 'package:get/instance_manager.dart';

import '../components/overview_scaffold/ioverview_scaffold.dart';
import '../components/overview_scaffold/staggered_scaffold.dart';

class OverviewScaffoldBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<IOverviewScaffold>(() => StaggeredScaffold());
  }
}