// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'managed_products_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ManagedProductsController on _ManagedProductsControllerBase, Store {
  final _$managedProductsAtom =
      Atom(name: '_ManagedProductsControllerBase.managedProducts');

  @override
  List<Product> get managedProducts {
    _$managedProductsAtom.context.enforceReadPolicy(_$managedProductsAtom);
    _$managedProductsAtom.reportObserved();
    return super.managedProducts;
  }

  @override
  set managedProducts(List<Product> value) {
    _$managedProductsAtom.context.conditionallyRunInAction(() {
      super.managedProducts = value;
      _$managedProductsAtom.reportChanged();
    }, _$managedProductsAtom, name: '${_$managedProductsAtom.name}_set');
  }

  final _$_ManagedProductsControllerBaseActionController =
      ActionController(name: '_ManagedProductsControllerBase');

  @override
  void getAll() {
    final _$actionInfo =
        _$_ManagedProductsControllerBaseActionController.startAction();
    try {
      return super.getAll();
    } finally {
      _$_ManagedProductsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(String id) {
    final _$actionInfo =
        _$_ManagedProductsControllerBaseActionController.startAction();
    try {
      return super.delete(id);
    } finally {
      _$_ManagedProductsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'managedProducts: ${managedProducts.toString()}';
    return '{$string}';
  }
}
