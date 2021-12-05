import 'package:get/instance_manager.dart';

import '../../modules/overview/core/overview_appbar/filter_options.dart';
import '../../modules/overview/core/overview_appbar/overview_appbar.dart';
import '../custom_widgets/custom_appbar.dart';

class CustomAppbarsBinding extends Bindings {
  void dependencies() {
    Get.lazyPut<CustomAppBar>(() => CustomAppBar());
    Get.lazyPut<OverviewAppBar>(() => OverviewAppBar(filter: FilterOptions.All));
  }
}