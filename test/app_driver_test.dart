import 'app/modules/cart/cart_test_groups.dart';
import 'app/modules/components/components_test_groups.dart';
import 'app/modules/inventory/inventory_test_groups.dart';
import 'app/modules/orders/orders_test_groups.dart';
import 'app/modules/overview/overview_test_groups.dart';

void main() {
  CartTestGroups.groups();
  OverviewTestGroups.groups();
  OrdersTestGroups.groups();
  InventoryTestGroups.groups();
  ComponentsTestGroups.groups();
}
