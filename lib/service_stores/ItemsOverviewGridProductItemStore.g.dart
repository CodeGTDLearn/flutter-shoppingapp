// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemsOverviewGridProductItemStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemsOverviewGridProductItemStore
    on IItemsOverviewGridProductItemStore, Store {
  final _$favoriteStatusAtom =
      Atom(name: 'IItemsOverviewGridProductItemStore.favoriteStatus');

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

  final _$IItemsOverviewGridProductItemStoreActionController =
      ActionController(name: 'IItemsOverviewGridProductItemStore');

  @override
  void toggleFavoriteStatus(String id) {
    final _$actionInfo =
        _$IItemsOverviewGridProductItemStoreActionController.startAction();
    try {
      return super.toggleFavoriteStatus(id);
    } finally {
      _$IItemsOverviewGridProductItemStoreActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'favoriteStatus: ${favoriteStatus.toString()}';
    return '{$string}';
  }
}
