import 'cart_test_groups.dart';
import 'managed_products_test_groups.dart';
import 'orders_test_groups.dart';
import 'overview_test_groups.dart';

void main() {
  OverviewModule.groups();
  CartModuleTestGroups.groups();
  OrdersModuleTestGroups.groups();
  ManagedProductsModuleTestGroups.groups();
}
