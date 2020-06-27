// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OverviewController on _OverviewControllerBase, Store {
  final _$filteredProductsAtom =
      Atom(name: '_OverviewControllerBase.filteredProducts');

  @override
  List<Product> get filteredProducts {
    _$filteredProductsAtom.context.enforceReadPolicy(_$filteredProductsAtom);
    _$filteredProductsAtom.reportObserved();
    return super.filteredProducts;
  }

  @override
  set filteredProducts(List<Product> value) {
    _$filteredProductsAtom.context.conditionallyRunInAction(() {
      super.filteredProducts = value;
      _$filteredProductsAtom.reportChanged();
    }, _$filteredProductsAtom, name: '${_$filteredProductsAtom.name}_set');
  }

  final _$hasFavoritesAtom = Atom(name: '_OverviewControllerBase.hasFavorites');

  @override
  bool get hasFavorites {
    _$hasFavoritesAtom.context.enforceReadPolicy(_$hasFavoritesAtom);
    _$hasFavoritesAtom.reportObserved();
    return super.hasFavorites;
  }

  @override
  set hasFavorites(bool value) {
    _$hasFavoritesAtom.context.conditionallyRunInAction(() {
      super.hasFavorites = value;
      _$hasFavoritesAtom.reportChanged();
    }, _$hasFavoritesAtom, name: '${_$hasFavoritesAtom.name}_set');
  }

  final _$_OverviewControllerBaseActionController =
      ActionController(name: '_OverviewControllerBase');

  @override
  void applyFilter(PopupEnum filter) {
    final _$actionInfo =
        _$_OverviewControllerBaseActionController.startAction();
    try {
      return super.applyFilter(filter);
    } finally {
      _$_OverviewControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'filteredProducts: ${filteredProducts.toString()},hasFavorites: ${hasFavorites.toString()}';
    return '{$string}';
  }
}
