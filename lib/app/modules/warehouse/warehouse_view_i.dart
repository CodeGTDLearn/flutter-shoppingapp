import 'warehouse.dart';

abstract class WarehouseViewI {
  List<Warehouse> onLoadWarehouses();

  void incrementIntObsAction();
}