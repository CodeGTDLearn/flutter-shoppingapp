
import '../../entity/inventory_depot.dart';

abstract class InventoryDeposDaoI {
    Future<List<InventoryDepot>> getDeposData();
}