// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_grid_product_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OverviewGridProductController
    on OverviewGridProductControllerBase, Store {
  final _$filteredProductsAtom =
      Atom(name: 'OverviewGridProductControllerBase.filteredProducts');

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

  final _$hasFavoritesAtom =
      Atom(name: 'OverviewGridProductControllerBase.hasFavorites');

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

  final _$OverviewGridProductControllerBaseActionController =
      ActionController(name: 'OverviewGridProductControllerBase');

  @override
  void applyFilter(PopupOptionsAppbar filter) {
    final _$actionInfo =
        _$OverviewGridProductControllerBaseActionController.startAction();
    try {
      return super.applyFilter(filter);
    } finally {
      _$OverviewGridProductControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'filteredProducts: ${filteredProducts.toString()},hasFavorites: ${hasFavorites.toString()}';
    return '{$string}';
  }
}
