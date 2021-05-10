import 'app/core/components/components_test_groups.dart';
import 'app/modules/cart/cart_test_groups.dart';
import 'app/modules/inventory/inventory_test_groups.dart';
import 'app/modules/orders/orders_test_groups.dart';
import 'app/modules/overview/overview_test_groups.dart';

void main() {
  CartTest().groups();
  OverviewTest().groups();
  InventoryTest().groups();
  ComponentsTest().groups();
  OrdersTest().groups();
}
