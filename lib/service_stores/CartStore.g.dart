// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on ICartStore, Store {
  final _$totalCartMoneyAmountAtom =
      Atom(name: 'ICartStore.totalCartMoneyAmount');

  @override
  String get totalCartMoneyAmount {
    _$totalCartMoneyAmountAtom.context
        .enforceReadPolicy(_$totalCartMoneyAmountAtom);
    _$totalCartMoneyAmountAtom.reportObserved();
    return super.totalCartMoneyAmount;
  }

  @override
  set totalCartMoneyAmount(String value) {
    _$totalCartMoneyAmountAtom.context.conditionallyRunInAction(() {
      super.totalCartMoneyAmount = value;
      _$totalCartMoneyAmountAtom.reportChanged();
    }, _$totalCartMoneyAmountAtom,
        name: '${_$totalCartMoneyAmountAtom.name}_set');
  }

  final _$totalCartItemsAtom = Atom(name: 'ICartStore.totalCartItems');

  @override
  String get totalCartItems {
    _$totalCartItemsAtom.context.enforceReadPolicy(_$totalCartItemsAtom);
    _$totalCartItemsAtom.reportObserved();
    return super.totalCartItems;
  }

  @override
  set totalCartItems(String value) {
    _$totalCartItemsAtom.context.conditionallyRunInAction(() {
      super.totalCartItems = value;
      _$totalCartItemsAtom.reportChanged();
    }, _$totalCartItemsAtom, name: '${_$totalCartItemsAtom.name}_set');
  }

  final _$ICartStoreActionController = ActionController(name: 'ICartStore');

  @override
  void addCartItem(Product product) {
    final _$actionInfo = _$ICartStoreActionController.startAction();
    try {
      return super.addCartItem(product);
    } finally {
      _$ICartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeCartItem(CartItem cartItem) {
    final _$actionInfo = _$ICartStoreActionController.startAction();
    try {
      return super.removeCartItem(cartItem);
    } finally {
      _$ICartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getTotalCartMoneyAmount() {
    final _$actionInfo = _$ICartStoreActionController.startAction();
    try {
      return super.getTotalCartMoneyAmount();
    } finally {
      _$ICartStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'totalCartMoneyAmount: ${totalCartMoneyAmount.toString()},totalCartItems: ${totalCartItems.toString()}';
    return '{$string}';
  }
}
