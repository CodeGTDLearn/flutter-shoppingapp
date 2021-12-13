import 'package:get/instance_manager.dart';

import '../../modules/overview/core/overview_scaffold/addcart_scaffold.dart';
import '../../modules/overview/core/overview_scaffold/icustom_scaffold.dart';

class CustomScaffoldBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<ICustomScaffold>(() => AddCartScaffold());
  }
}