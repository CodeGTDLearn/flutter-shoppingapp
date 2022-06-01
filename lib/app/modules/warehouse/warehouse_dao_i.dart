import 'warehouse.dart';

abstract class WarehouseDaoI {
  Future<List<Warehouse>> getWarehouses();
}