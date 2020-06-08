// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'managedProductsStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ManagedProductsStore on ManagedProductsStoreInt, Store {
  final _$qtdeManagedProductsAtom =
      Atom(name: 'ManagedProductsStoreInt.qtdeManagedProducts');

  @override
  int get qtdeManagedProducts {
    _$qtdeManagedProductsAtom.context
        .enforceReadPolicy(_$qtdeManagedProductsAtom);
    _$qtdeManagedProductsAtom.reportObserved();
    return super.qtdeManagedProducts;
  }

  @override
  set qtdeManagedProducts(int value) {
    _$qtdeManagedProductsAtom.context.conditionallyRunInAction(() {
      super.qtdeManagedProducts = value;
      _$qtdeManagedProductsAtom.reportChanged();
    }, _$qtdeManagedProductsAtom,
        name: '${_$qtdeManagedProductsAtom.name}_set');
  }

  final _$productsAtom = Atom(name: 'ManagedProductsStoreInt.products');

  @override
  List<Product> get products {
    _$productsAtom.context.enforceReadPolicy(_$productsAtom);
    _$productsAtom.reportObserved();
    return super.products;
  }

  @override
  set products(List<Product> value) {
    _$productsAtom.context.conditionallyRunInAction(() {
      super.products = value;
      _$productsAtom.reportChanged();
    }, _$productsAtom, name: '${_$productsAtom.name}_set');
  }

  final _$ManagedProductsStoreIntActionController =
      ActionController(name: 'ManagedProductsStoreInt');

  @override
  List<Product> getAll() {
    final _$actionInfo =
        _$ManagedProductsStoreIntActionController.startAction();
    try {
      return super.getAll();
    } finally {
      _$ManagedProductsStoreIntActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool add(Product product) {
    final _$actionInfo =
        _$ManagedProductsStoreIntActionController.startAction();
    try {
      return super.add(product);
    } finally {
      _$ManagedProductsStoreIntActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool update(Product product) {
    final _$actionInfo =
        _$ManagedProductsStoreIntActionController.startAction();
    try {
      return super.update(product);
    } finally {
      _$ManagedProductsStoreIntActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(String id) {
    final _$actionInfo =
        _$ManagedProductsStoreIntActionController.startAction();
    try {
      return super.delete(id);
    } finally {
      _$ManagedProductsStoreIntActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'qtdeManagedProducts: ${qtdeManagedProducts.toString()},products: ${products.toString()}';
    return '{$string}';
  }
}
