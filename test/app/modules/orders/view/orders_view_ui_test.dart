import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/orders.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../test_utils/test_utils.dart';
import '../orders_test_config.dart';

Future grupo01() async {
  group('View: UI', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    TestUtils _seek;

    setUp(() {
      // OrdersTestConfig().bindingsBuilderMockedRepo();
      _seek = TestUtils();
    });

    tearDown(() => _seek = null);

    testWidgets('1 --> Opening OrderPage WITH an Order in DB', (tester) async {
      app.main(); //09:42 Youtube

      await tester.pumpAndSettle();

      OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
      await tester.pump(_seek.delay(5));
      await tester.tap(_seek.key(DRAWWER_ORDER_OPTION));
      await tester.pump(_seek.delay(5));
    });

    testWidgets('2 --> Opening OrderPage WITH an Order in DB', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
      await tester.pump(_seek.delay(2));
      await tester.tap(_seek.key(DRAWWER_ORDER_OPTION));
      await tester.pump(_seek.delay(2));
    });
  });
}
