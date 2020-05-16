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

  @override
  String toString() {
    final string = 'qtdeManagedProducts: ${qtdeManagedProducts.toString()}';
    return '{$string}';
  }
}
