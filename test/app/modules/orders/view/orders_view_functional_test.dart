import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_test_config.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../orders_test_config.dart';
import 'orders_view_tests.dart';

class OrdersViewFunctionalTest {
  final bool excludeGuiTest;

  OrdersViewFunctionalTest({this.excludeGuiTest});

  void functional() {
    var _bindings;
    var _tests = Get.put(OrdersViewTests());
    var _config = Get.put(OrdersTestConfig());
    final _viewTestUtils = ViewTestUtils();

    // setUp(() => _bindings = _config.bindingsBuilderMockedRepo(execute: true));
    setUp(() => _bindings = _config.bindingsBuilderMockedRepo(execute: excludeGuiTest));

    tearDown(Get.reset);

    testWidgets('${_config.OpenOrderView_NoneOrderInDB}', (tester) async {
      // _bindings = _config.bindingsBuilderMockRepoEmptyDb(execute: true);
      _bindings = _config.bindingsBuilderMockRepoEmptyDb(execute: excludeGuiTest);
      _bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.OpenOrderView_NoOrderInDB(tester, DELAY);
    });

    testWidgets('${_config.OrderingFromCartView_TapingTheButtonOrderNow}',
        (tester) async {
      _bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _tests.OrderingFromCartView_TapButtonOrderNow(tester, DELAY);
    });

    testWidgets('${_config.OpenOrderView_WithAnOrderInDB}', (tester) async {
      _bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _viewTestUtils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        keyOption: DRAWER_ORDER_OPTION_KEY,
        scaffoldGlobalKey: OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY,
      );

      _viewTestUtils.checkWidgetsQtdeInOneView(
          widgetView: OrdersView, widgetElement: OrderCollapsableTile, widgetQtde: 1);
    });

    testWidgets('${_config.TapPageBackButton_InOrderView}', (tester) async {
      _bindings ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _viewTestUtils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        keyOption: DRAWER_ORDER_OPTION_KEY,
        scaffoldGlobalKey: OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY,
      );

      await _tests.OpenOrderView_TapBackButton(
        tester,
        DELAY,
        from: OrdersView,
        to: OverviewView,
      );
    });
  }
}

