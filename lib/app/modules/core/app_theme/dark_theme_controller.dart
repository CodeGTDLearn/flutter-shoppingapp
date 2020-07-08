import 'package:get/get.dart';

import '../shared_preferences/shared_prefs_repo.dart';
import 'app_theme.dart';

class DarkThemeController extends GetxController {
  final SharedPrefsRepo _repo = Get.put<SharedPrefsRepo>(SharedPrefsRepo());

  var isDark = false.obs;

  void toggleDarkTheme(bool value) {
    _repo.put('isDarkOption', value);
    isDark.value = value;
    Get.changeTheme(
        Get.isDarkMode ? AppTheme().theme(false) : AppTheme().theme(true));
  }
}
