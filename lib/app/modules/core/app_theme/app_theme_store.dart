import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../shared_preferences/shared_preferences_repo.dart';

part 'app_theme_store.g.dart';

class AppThemeStore = _AppThemeStoreBase with _$AppThemeStore;

abstract class _AppThemeStoreBase with Store {
  final _store = Modular.get<SharedPreferencesRepo>();

  @observable
  bool isDark = false;

  @action
  void toggleDarkTheme(bool onChangedValue) {
    _store.put('isDark', onChangedValue);
    isDark = onChangedValue;
  }
}
