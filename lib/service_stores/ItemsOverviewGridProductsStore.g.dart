// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ItemsOverviewGridProductsStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemsOverviewGridProductsStore
    on IItemsOverviewGridProductsStore, Store {
  final _$filteredProductsAtom =
      Atom(name: 'IItemsOverviewGridProductsStore.filteredProducts');

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

  final _$IItemsOverviewGridProductsStoreActionController =
      ActionController(name: 'IItemsOverviewGridProductsStore');

  @override
  void applyFilter(ItemsOverviewPopup filter) {
    final _$actionInfo =
        _$IItemsOverviewGridProductsStoreActionController.startAction();
    try {
      return super.applyFilter(filter);
    } finally {
      _$IItemsOverviewGridProductsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'filteredProducts: ${filteredProducts.toString()}';
    return '{$string}';
  }
}
