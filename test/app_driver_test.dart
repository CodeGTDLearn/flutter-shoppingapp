import 'test_utils/test_groups/cart_test_groups.dart';
import 'test_utils/test_groups/components_test_groups.dart';
import 'test_utils/test_groups/inventory_test_groups.dart';
import 'test_utils/test_groups/orders_test_groups.dart';
import 'test_utils/test_groups/overview_test_groups.dart';

void main() {
  CartTestGroups.groups();
  OverviewTestGroups.groups();
  OrdersTestGroups.groups();
  InventoryTestGroups.groups();
  ComponentsTestGroups.groups();
}
