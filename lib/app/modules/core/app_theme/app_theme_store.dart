import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/app/modules/core/shared_preferences/shared_preferences_repo.dart';

part 'app_theme_store.g.dart';

class AppThemeStore = AppThemeStoreBase with _$AppThemeStore;

abstract class AppThemeStoreBase with Store {
  final _store = Modular.get<SharedPreferencesRepo>();

  @observable
  bool isDark = false;

  @action
  void toggleDarkTheme(bool onChangedValue) {
    this._store.put('isDark', onChangedValue);
    this.isDark = onChangedValue;
  }
}
