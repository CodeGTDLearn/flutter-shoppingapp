import 'package:mobx/mobx.dart';

import 'warehouse.dart';
import 'warehouse_dao.dart';
import 'warehouse_dao_i.dart';

//https://flutterappworld.com/flutter-mvp-demo/
//https://www.youtube.com/watch?v=I2AgSDAEZSE
abstract class WarehouseViewContractI {
  void onLoadWarehouses(List<Warehouse> warehouses);
}

class WarehousePresenter {
  final WarehouseViewContractI _viewContract;
  late final WarehouseDaoI _dao;


  WarehousePresenter(this._viewContract) {
    _dao = WarehouseDao();
  }

  final warehousesObs = ObservableList<Warehouse>(name: "_warehousesObs");
  final intObs = Observable<int>(0, name: "_intObs");

  void loadWarehouses() {
    _dao.getWarehouses()
        .then((warehouses) => _viewContract.onLoadWarehouses(warehouses))
        .catchError((onError) => "cc");
  }
}
/*╔═══════════════════════╗
    ║ STYLE 01: MobX ACTION ║
    ╠═══════════════════════╣
    ║   NO-CODE-GENERATOR   ║
    ╠═══════════════════════╣
    ║        Action         ║
    ╚═══════════════════════╝
  late final incrementIntObsActionStyle1 = Action(
    () => {++intObs.value},
    name: "incrementIntObsActionStyle1",
  );

  /*╔═══════════════════════╗
    ║ STYLE 02: MobX ACTION ║
    ╠═══════════════════════╣
    ║   NO-CODE-GENERATOR   ║
    ╠═══════════════════════╣
    ║      runInAction      ║
    ╚═══════════════════════╝*/
  void incrementIntObsActionStyle2() {
    runInAction(() {
      ++intObs.value;
    }, name: "incrementIntObsActionStyle2");
  }*/