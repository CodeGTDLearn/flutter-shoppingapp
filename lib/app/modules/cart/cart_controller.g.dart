// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartController on _CartControllerBase, Store {
  final _$amountCartItemsAtom =
      Atom(name: '_CartControllerBase.amountCartItems');

  @override
  double get amountCartItems {
    _$amountCartItemsAtom.context.enforceReadPolicy(_$amountCartItemsAtom);
    _$amountCartItemsAtom.reportObserved();
    return super.amountCartItems;
  }

  @override
  set amountCartItems(double value) {
    _$amountCartItemsAtom.context.conditionallyRunInAction(() {
      super.amountCartItems = value;
      _$amountCartItemsAtom.reportChanged();
    }, _$amountCartItemsAtom, name: '${_$amountCartItemsAtom.name}_set');
  }

  final _$qtdeCartItemsAtom = Atom(name: '_CartControllerBase.qtdeCartItems');

  @override
  int get qtdeCartItems {
    _$qtdeCartItemsAtom.context.enforceReadPolicy(_$qtdeCartItemsAtom);
    _$qtdeCartItemsAtom.reportObserved();
    return super.qtdeCartItems;
  }

  @override
  set qtdeCartItems(int value) {
    _$qtdeCartItemsAtom.context.conditionallyRunInAction(() {
      super.qtdeCartItems = value;
      _$qtdeCartItemsAtom.reportChanged();
    }, _$qtdeCartItemsAtom, name: '${_$qtdeCartItemsAtom.name}_set');
  }

  final _$_CartControllerBaseActionController =
      ActionController(name: '_CartControllerBase');

  @override
  void addProductInTheCart(Product product) {
    final _$actionInfo = _$_CartControllerBaseActionController.startAction();
    try {
      return super.addProductInTheCart(product);
    } finally {
      _$_CartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void undoAddProductInTheCart(Product product) {
    final _$actionInfo = _$_CartControllerBaseActionController.startAction();
    try {
      return super.undoAddProductInTheCart(product);
    } finally {
      _$_CartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeCartItem(CartItem cartItem) {
    final _$actionInfo = _$_CartControllerBaseActionController.startAction();
    try {
      return super.removeCartItem(cartItem);
    } finally {
      _$_CartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCart() {
    final _$actionInfo = _$_CartControllerBaseActionController.startAction();
    try {
      return super.clearCart();
    } finally {
      _$_CartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'amountCartItems: ${amountCartItems.toString()},qtdeCartItems: ${qtdeCartItems.toString()}';
    return '{$string}';
  }
}
