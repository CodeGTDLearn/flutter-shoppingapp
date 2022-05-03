// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_depos_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InventoryDeposPresenter on _Presenter, Store {
  late final _$depoAtom = Atom(name: '_Presenter.depo', context: context);

  @override
  dynamic get depo {
    _$depoAtom.reportRead();
    return super.depo;
  }

  @override
  set depo(dynamic value) {
    _$depoAtom.reportWrite(value, super.depo, () {
      super.depo = value;
    });
  }

  late final _$_PresenterActionController =
      ActionController(name: '_Presenter', context: context);

  @override
  void getDeposData() {
    final _$actionInfo = _$_PresenterActionController.startAction(
        name: '_Presenter.getDeposData');
    try {
      return super.getDeposData();
    } finally {
      _$_PresenterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
depo: ${depo}
    ''';
  }
}
