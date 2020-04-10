// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrdersStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrdersStore on IOrdersStore, Store {
  final _$isCollapsedAtom = Atom(name: 'IOrdersStore.isCollapsed');

  @override
  bool get isCollapsed {
    _$isCollapsedAtom.context.enforceReadPolicy(_$isCollapsedAtom);
    _$isCollapsedAtom.reportObserved();
    return super.isCollapsed;
  }

  @override
  set isCollapsed(bool value) {
    _$isCollapsedAtom.context.conditionallyRunInAction(() {
      super.isCollapsed = value;
      _$isCollapsedAtom.reportChanged();
    }, _$isCollapsedAtom, name: '${_$isCollapsedAtom.name}_set');
  }

  final _$totalOrdersAtom = Atom(name: 'IOrdersStore.totalOrders');

  @override
  int get totalOrders {
    _$totalOrdersAtom.context.enforceReadPolicy(_$totalOrdersAtom);
    _$totalOrdersAtom.reportObserved();
    return super.totalOrders;
  }

  @override
  set totalOrders(int value) {
    _$totalOrdersAtom.context.conditionallyRunInAction(() {
      super.totalOrders = value;
      _$totalOrdersAtom.reportChanged();
    }, _$totalOrdersAtom, name: '${_$totalOrdersAtom.name}_set');
  }

  final _$IOrdersStoreActionController = ActionController(name: 'IOrdersStore');

  @override
  void toggleCollapseTile() {
    final _$actionInfo = _$IOrdersStoreActionController.startAction();
    try {
      return super.toggleCollapseTile();
    } finally {
      _$IOrdersStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isCollapsed: ${isCollapsed.toString()},totalOrders: ${totalOrders.toString()}';
    return '{$string}';
  }
}
