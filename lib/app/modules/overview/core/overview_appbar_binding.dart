import 'package:get/instance_manager.dart';

import 'overview_appbar/filter_options.dart';
import 'overview_appbar/overview_appbar.dart';

class OverviewAppbarBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<OverviewAppBar>(() => OverviewAppBar(filter: FilterOptions.All));
  }
}