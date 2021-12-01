import 'package:get/instance_manager.dart';

import '../../modules/cart/repo/cart_repo.dart';
import '../../modules/cart/repo/i_cart_repo.dart';
import '../properties/theme/app_theme_controller.dart';

class GlobalBindings extends Bindings {
  void dependencies() {
    Get.lazyPut<AppThemeController>(() => AppThemeController());
    Get.put<ICartRepo>(CartRepo(), permanent: true, tag: 'persistentCartRepo');
  }
}