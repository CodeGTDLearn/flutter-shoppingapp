import 'package:get/instance_manager.dart';

import '../../../modules/overview/components/overview_scaffold/icustom_scaffold.dart';
import '../../../modules/overview/components/overview_scaffold/staggered_scaffold.dart';

class CustomScaffoldBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<ICustomScaffold>(() => StaggeredScaffold());
  }
}