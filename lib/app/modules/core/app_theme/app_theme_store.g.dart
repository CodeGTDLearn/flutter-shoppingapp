// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppThemeStore on AppThemeStoreBase, Store {
  final _$isDarkAtom = Atom(name: 'AppThemeStoreBase.isDark');

  @override
  bool get isDark {
    _$isDarkAtom.context.enforceReadPolicy(_$isDarkAtom);
    _$isDarkAtom.reportObserved();
    return super.isDark;
  }

  @override
  set isDark(bool value) {
    _$isDarkAtom.context.conditionallyRunInAction(() {
      super.isDark = value;
      _$isDarkAtom.reportChanged();
    }, _$isDarkAtom, name: '${_$isDarkAtom.name}_set');
  }

  final _$AppThemeStoreBaseActionController =
      ActionController(name: 'AppThemeStoreBase');

  @override
  void toggleDarkTheme(bool onChangedValue) {
    final _$actionInfo = _$AppThemeStoreBaseActionController.startAction();
    try {
      return super.toggleDarkTheme(onChangedValue);
    } finally {
      _$AppThemeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isDark: ${isDark.toString()}';
    return '{$string}';
  }
}
