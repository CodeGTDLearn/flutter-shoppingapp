import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'app/core/components/components_test_groups.dart';
import 'app/modules/cart/cart_test_groups.dart';
import 'app/modules/inventory/inventory_test_groups.dart';
import 'app/modules/orders/orders_test_groups.dart';
import 'app/modules/orders/view/orders_view_functional_test.dart';
import 'app/modules/overview/overview_test_groups.dart';

void main() {
  final _env = String.fromEnvironment('TEST').toLowerCase();
  bool _exclude;
  if (_env != null && _env == 'func') _exclude = true;
  if (_env != null && _env == 'gui') _exclude = false;
  if (_env != null && (_env != 'gui' && _env != 'func')) _exclude = true;

  print('>>>env-variable: >>> $_env >>>>> $_exclude');

  if (_exclude) {
    CartTest().groups();
    OverviewTest().groups();
    InventoryTest().groups();
    ComponentsTest().groups();
    OrdersTest().groups();
  } else {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    group('Orders|Gui-Tests: ',
        OrdersViewFunctionalTest(excludeGuiTest: _exclude).functional);
  }
}
