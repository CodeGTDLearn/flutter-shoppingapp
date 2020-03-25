// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_overview_serv_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemsOverviewServStore on IItemsOverviewServStore, Store {
  final _$filteredProductsAtom =
      Atom(name: 'IItemsOverviewServStore.filteredProducts');

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

  final _$IItemsOverviewServStoreActionController =
      ActionController(name: 'IItemsOverviewServStore');

  @override
  void applyFilter(ItemsOverviewPopup filterSelected) {
    final _$actionInfo =
        _$IItemsOverviewServStoreActionController.startAction();
    try {
      return super.applyFilter(filterSelected);
    } finally {
      _$IItemsOverviewServStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'filteredProducts: ${filteredProducts.toString()}';
    return '{$string}';
  }
}
