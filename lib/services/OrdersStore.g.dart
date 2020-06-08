// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordersStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OrdersStore on OrdersStoreInt, Store {
  final _$qtdeOrdersAtom = Atom(name: 'OrdersStoreInt.qtdeOrders');

  @override
  int get qtdeOrders {
    _$qtdeOrdersAtom.context.enforceReadPolicy(_$qtdeOrdersAtom);
    _$qtdeOrdersAtom.reportObserved();
    return super.qtdeOrders;
  }

  @override
  set qtdeOrders(int value) {
    _$qtdeOrdersAtom.context.conditionallyRunInAction(() {
      super.qtdeOrders = value;
      _$qtdeOrdersAtom.reportChanged();
    }, _$qtdeOrdersAtom, name: '${_$qtdeOrdersAtom.name}_set');
  }

  @override
  String toString() {
    final string = 'qtdeOrders: ${qtdeOrders.toString()}';
    return '{$string}';
  }
}
