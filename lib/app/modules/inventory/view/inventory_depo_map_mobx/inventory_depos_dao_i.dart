

import '../../entity/inventory_depo.dart';

abstract class InventoryDeposDaoI {
    Future<List<InventoryDepo>> getDeposData();
}