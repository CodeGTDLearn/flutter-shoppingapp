// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_overview_serv_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemsOverviewServStore on IItemsOverviewServStore, Store {
  final _$filterSelectedAtom =
      Atom(name: 'IItemsOverviewServStore.filterSelected');

  @override
  int get filterSelected {
    _$filterSelectedAtom.context.enforceReadPolicy(_$filterSelectedAtom);
    _$filterSelectedAtom.reportObserved();
    return super.filterSelected;
  }

  @override
  set filterSelected(int value) {
    _$filterSelectedAtom.context.conditionallyRunInAction(() {
      super.filterSelected = value;
      _$filterSelectedAtom.reportChanged();
    }, _$filterSelectedAtom, name: '${_$filterSelectedAtom.name}_set');
  }

  final _$IItemsOverviewServStoreActionController =
      ActionController(name: 'IItemsOverviewServStore');

  @override
  void selectFilter(int popupSelection) {
    final _$actionInfo =
        _$IItemsOverviewServStoreActionController.startAction();
    try {
      return super.selectFilter(popupSelection);
    } finally {
      _$IItemsOverviewServStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'filterSelected: ${filterSelected.toString()}';
    return '{$string}';
  }
}
