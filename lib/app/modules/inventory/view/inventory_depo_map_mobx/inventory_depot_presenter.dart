import 'package:mobx/mobx.dart';

import '../../entity/inventory_depot.dart';
import 'inventory_depos_dao_i.dart';
import 'inventory_depos_view_i.dart';

part 'inventory_depot_presenter.g.dart';

class InventoryDepotPresenter = _Presenter with _$InventoryDepotPresenter;
//https://flutterappworld.com/flutter-mvp-demo/
//https://www.youtube.com/watch?v=I2AgSDAEZSE
abstract class _Presenter with Store {
  late InventoryDeposViewI _view;
  late InventoryDeposDaoI _dao;

  @observable
  late InventoryDepot depo;

  @action
  void getDeposData() {
    _dao.getDeposData().then((value) => _view.onLoadDepos(value));
  }
}