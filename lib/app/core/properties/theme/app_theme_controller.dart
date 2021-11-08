import 'package:get/get.dart';

import '../../shared_preferences/i_shared_prefs_repo.dart';
import '../../shared_preferences/shared_prefs_repo.dart';
import 'app_theme.dart';

class AppThemeController extends GetxController {
  final ISharedPrefsRepo _sharedPreferencesRepo = Get.put(SharedPrefsRepo());

  var isDark = false.obs;

  void toggleDarkTheme(bool value) {
    _sharedPreferencesRepo.put('isDarkOption', value);
    isDark.value = value;
    Get.changeTheme(
      Get.isDarkMode ? AppTheme().theme(false) : AppTheme().theme(true),
    );
  }
}