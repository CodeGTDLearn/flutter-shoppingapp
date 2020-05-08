// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on CartStoreInt, Store {
  final _$totalMoneyCartItemsAtom =
      Atom(name: 'CartStoreInt.totalMoneyCartItems');

  @override
  double get totalMoneyCartItems {
    _$totalMoneyCartItemsAtom.context
        .enforceReadPolicy(_$totalMoneyCartItemsAtom);
    _$totalMoneyCartItemsAtom.reportObserved();
    return super.totalMoneyCartItems;
  }

  @override
  set totalMoneyCartItems(double value) {
    _$totalMoneyCartItemsAtom.context.conditionallyRunInAction(() {
      super.totalMoneyCartItems = value;
      _$totalMoneyCartItemsAtom.reportChanged();
    }, _$totalMoneyCartItemsAtom,
        name: '${_$totalMoneyCartItemsAtom.name}_set');
  }

  final _$totalQtdeCartItemsAtom =
      Atom(name: 'CartStoreInt.totalQtdeCartItems');

  @override
  int get totalQtdeCartItems {
    _$totalQtdeCartItemsAtom.context
        .enforceReadPolicy(_$totalQtdeCartItemsAtom);
    _$totalQtdeCartItemsAtom.reportObserved();
    return super.totalQtdeCartItems;
  }

  @override
  set totalQtdeCartItems(int value) {
    _$totalQtdeCartItemsAtom.context.conditionallyRunInAction(() {
      super.totalQtdeCartItems = value;
      _$totalQtdeCartItemsAtom.reportChanged();
    }, _$totalQtdeCartItemsAtom, name: '${_$totalQtdeCartItemsAtom.name}_set');
  }

  final _$CartStoreIntActionController = ActionController(name: 'CartStoreInt');

  @override
  void addCartItem(Product product) {
    final _$actionInfo = _$CartStoreIntActionController.startAction();
    try {
      return super.addCartItem(product);
    } finally {
      _$CartStoreIntActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeCartItem(CartItem cartItem) {
    final _$actionInfo = _$CartStoreIntActionController.startAction();
    try {
      return super.removeCartItem(cartItem);
    } finally {
      _$CartStoreIntActionController.endAction(_$actionInfo);
    }
  }

  @override
  void calcTotalCartMoneyAmount() {
    final _$actionInfo = _$CartStoreIntActionController.startAction();
    try {
      return super.calcTotalCartMoneyAmount();
    } finally {
      _$CartStoreIntActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'totalMoneyCartItems: ${totalMoneyCartItems.toString()},totalQtdeCartItems: ${totalQtdeCartItems.toString()}';
    return '{$string}';
  }
}
