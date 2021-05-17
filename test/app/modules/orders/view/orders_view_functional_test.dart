import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_tests_config.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../orders_test_config.dart';
import 'orders_view_tests.dart';

class OrdersViewFunctionalTest {
  bool _unitTests;

  OrdersViewFunctionalTest({String testType}) {
    _unitTests = testType == UNIT_TESTS;
  }

  void functional() {
    var _tests = Get.put(OrdersViewTests());
    var _config = Get.put(OrdersTestConfig());
    final _viewTestUtils = ViewTestUtils();

    setUpAll(_viewTestUtils.setUpAll);

    tearDownAll(_viewTestUtils.tearDownAll);

    setUp(() => _config.bindingsBuilderMockedRepo(execute: _unitTests));

    tearDown(Get.reset);

    testWidgets('${_config.OpenOrderView_NoneOrderInDB}', (tester) async {
      _config.bindingsBuilderMockRepoEmptyDb(execute: _unitTests);
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _viewTestUtils.removeFromDb(tester, url: ORDERS_URL, delaySeconds: 1);
      await _viewTestUtils.removeFromDb(tester, url: PRODUCTS_URL, delaySeconds: 1);
      await _viewTestUtils.removeFromDb(tester, url: CART_ITEM_URL, delaySeconds: 1);

      await _tests.OpenOrderView_NoOrderInDB(tester, DELAY);
    });

    testWidgets('${_config.OrderingFromCartView_TapingTheButtonOrderNow}',
        (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      _unitTests
          ? isNull
          : await _tests.AddOneProductInDB(tester, DELAY, validTexts: true);
      await _tests.OrderingFromCartView_TapButtonOrderNow(tester, DELAY);
    });

    testWidgets('${_config.OpenOrderView_OneOrderInDB}', (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

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
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

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
