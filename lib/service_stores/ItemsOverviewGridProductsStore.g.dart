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

  final _$pageTitleAtom =
      Atom(name: 'IItemsOverviewGridProductsStore.pageTitle');

  @override
  String get pageTitle {
    _$pageTitleAtom.context.enforceReadPolicy(_$pageTitleAtom);
    _$pageTitleAtom.reportObserved();
    return super.pageTitle;
  }

  @override
  set pageTitle(String value) {
    _$pageTitleAtom.context.conditionallyRunInAction(() {
      super.pageTitle = value;
      _$pageTitleAtom.reportChanged();
    }, _$pageTitleAtom, name: '${_$pageTitleAtom.name}_set');
  }

  final _$IItemsOverviewGridProductsStoreActionController =
      ActionController(name: 'IItemsOverviewGridProductsStore');

  @override
  void applyFilter(ItemsOverviewPopup filter, BuildContext context) {
    final _$actionInfo =
        _$IItemsOverviewGridProductsStoreActionController.startAction();
    try {
      return super.applyFilter(filter, context);
    } finally {
      _$IItemsOverviewGridProductsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'filteredProducts: ${filteredProducts.toString()},pageTitle: ${pageTitle.toString()}';
    return '{$string}';
  }
}
