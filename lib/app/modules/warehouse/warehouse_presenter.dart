import 'package:mobx/mobx.dart';

import 'warehouse.dart';
import 'warehouse_dao.dart';
import 'warehouse_dao_i.dart';

//https://flutterappworld.com/flutter-mvp-demo/
//https://www.youtube.com/watch?v=I2AgSDAEZSE
abstract class WarehouseViewContractI {
  List<Warehouse> onLoadWarehouses();
  void incrementIntObsAction();
}

class WarehousePresenter {
  final WarehouseViewContractI _viewContract;
  late final WarehouseDaoI _dao;
//https://youtu.be/I2AgSDAEZSE
  //45:12 - construindo o presenter
  WarehousePresenter(this._viewContract) {
    _dao = WarehouseDao();
  }

  final warehousesObs = ObservableList<Warehouse>(name: "_warehousesObs");
  final intObs = Observable<int>(0, name: "_intObs");

  // @formatter:off
  void loadWarehousesObsAction() {
    var string = runtimeType.toString();
    print(string);
    runInAction(
      () {
        _dao
            .getWarehouses()
            .then((warehouses) => _viewContract.onLoadWarehouses())
            .catchError((onError) => "cc")
            ;
      },
      // name: string,
    );
  }
  // @formatter:on

  /*╔═══════════════════════╗
    ║ STYLE 01: MobX ACTION ║
    ╠═══════════════════════╣
    ║   NO-CODE-GENERATOR   ║
    ╠═══════════════════════╣
    ║        Action         ║
    ╚═══════════════════════╝*/
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
  }
}