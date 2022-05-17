import 'package:mobx/mobx.dart';

import 'warehouse.dart';
import 'warehouse_dao.dart';
import 'warehouse_dao_i.dart';
import 'warehouse_view_i.dart';

//https://flutterappworld.com/flutter-mvp-demo/
//https://www.youtube.com/watch?v=I2AgSDAEZSE
class WarehousePresenter {
  final WarehouseViewI _view;
  late final WarehouseDaoI _dao;

  WarehousePresenter(this._view) {
    _dao = WarehouseDao();
  }

  final warehousesObs = ObservableList<Warehouse>(name: "_warehousesObs");
  final intObs = Observable<int>(0,
      // name: "_intObs"
  );

  void loadWarehousesObsAction() {
    var string = runtimeType.toString();
    print(string);
    runInAction(
      () {
        _dao
            .getWarehouses()
            .then((warehouses) => _view.onLoadWarehouses())
            // .catchError((onError) => "cc")
        ;
      },
      // name: string,
    );
  }

  void incrementIntObsAction() {
    var string = runtimeType.toString();
    print(string);
    runInAction(
      () {
        ++intObs.value;
      },
      // name: string,
    );
  }
}