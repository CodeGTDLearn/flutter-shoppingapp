// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_item_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OverviewItemController on _OverviewItemControllerBase, Store {
  final _$favoriteStatusAtom =
      Atom(name: '_OverviewItemControllerBase.favoriteStatus');

  @override
  bool get favoriteStatus {
    _$favoriteStatusAtom.context.enforceReadPolicy(_$favoriteStatusAtom);
    _$favoriteStatusAtom.reportObserved();
    return super.favoriteStatus;
  }

  @override
  set favoriteStatus(bool value) {
    _$favoriteStatusAtom.context.conditionallyRunInAction(() {
      super.favoriteStatus = value;
      _$favoriteStatusAtom.reportChanged();
    }, _$favoriteStatusAtom, name: '${_$favoriteStatusAtom.name}_set');
  }

  final _$_OverviewItemControllerBaseActionController =
      ActionController(name: '_OverviewItemControllerBase');

  @override
  void toggleFavoriteStatus(String id) {
    final _$actionInfo =
        _$_OverviewItemControllerBaseActionController.startAction();
    try {
      return super.toggleFavoriteStatus(id);
    } finally {
      _$_OverviewItemControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'favoriteStatus: ${favoriteStatus.toString()}';
    return '{$string}';
  }
}
