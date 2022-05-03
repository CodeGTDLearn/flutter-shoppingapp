import 'package:mobx/mobx.dart';

import '../../entity/inventory_depo.dart';
import 'inventory_depos_dao_i.dart';
import 'inventory_depos_view_i.dart';

part 'inventory_depos_presenter.g.dart';

class InventoryDeposPresenter = _Presenter with _$InventoryDeposPresenter;
//https://flutterappworld.com/flutter-mvp-demo/
//https://www.youtube.com/watch?v=I2AgSDAEZSE
abstract class _Presenter with Store {
  late InventoryDeposViewI _view;
  late InventoryDeposDaoI _dao;

  @observable
  late InventoryDepo depo;

  @action
  void getDeposData() {
    _dao.getDeposData().then((value) => _view.onLoadDepos(value));
  }
}