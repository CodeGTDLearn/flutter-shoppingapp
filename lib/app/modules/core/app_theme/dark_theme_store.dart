import 'package:get/get.dart';
import 'package:mobx/mobx.dart';

import '../shared_preferences/shared_preferences_repo.dart';

class DarkThemeStore  {
  final SharedPreferencesRepo _repo = Get.put(SharedPreferencesRepo());

  @observable
  bool isDark = false;

  @action
  void toggleDarkTheme(bool onChangedValue) {
    _repo.put('isDark', onChangedValue);
    isDark = onChangedValue;
  }
}
