// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on CartStoreInt, Store {
  final _$amountCartItemsAtom = Atom(name: 'CartStoreInt.amountCartItems');

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

  final _$qtdeCartItemsAtom = Atom(name: 'CartStoreInt.qtdeCartItems');

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

  final _$addProductInTheCartNotificationAtom =
      Atom(name: 'CartStoreInt.addProductInTheCartNotification');

  @override
  bool get addProductInTheCartNotification {
    _$addProductInTheCartNotificationAtom.context
        .enforceReadPolicy(_$addProductInTheCartNotificationAtom);
    _$addProductInTheCartNotificationAtom.reportObserved();
    return super.addProductInTheCartNotification;
  }

  @override
  set addProductInTheCartNotification(bool value) {
    _$addProductInTheCartNotificationAtom.context.conditionallyRunInAction(() {
      super.addProductInTheCartNotification = value;
      _$addProductInTheCartNotificationAtom.reportChanged();
    }, _$addProductInTheCartNotificationAtom,
        name: '${_$addProductInTheCartNotificationAtom.name}_set');
  }

  final _$CartStoreIntActionController = ActionController(name: 'CartStoreInt');

  @override
  void addProductInTheCart(Product product) {
    final _$actionInfo = _$CartStoreIntActionController.startAction();
    try {
      return super.addProductInTheCart(product);
    } finally {
      _$CartStoreIntActionController.endAction(_$actionInfo);
    }
  }

  @override
  void undoAddProductInTheCart(Product product) {
    final _$actionInfo = _$CartStoreIntActionController.startAction();
    try {
      return super.undoAddProductInTheCart(product);
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
  void calcAmount$CartItems() {
    final _$actionInfo = _$CartStoreIntActionController.startAction();
    try {
      return super.calcAmount$CartItems();
    } finally {
      _$CartStoreIntActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'amountCartItems: ${amountCartItems.toString()},qtdeCartItems: ${qtdeCartItems.toString()},addProductInTheCartNotification: ${addProductInTheCartNotification.toString()}';
    return '{$string}';
  }
}
