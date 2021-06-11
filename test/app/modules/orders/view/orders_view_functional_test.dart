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
import '../../../../data_builders/product_databuilder.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../orders_test_config.dart';
import 'orders_view_tests.dart';

class OrdersViewFunctionalTest {
  bool _unitTest;

  OrdersViewFunctionalTest({String testType}) {
    _unitTest = testType == UNIT_TEST;
  }

  void functional() {
    var _tests = Get.put(OrdersViewTests());
    var _config = Get.put(OrdersTestConfig());
    final _utils = Get.put(ViewTestUtils());

    setUpAll(() => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(execute: _unitTest);
    });

    tearDown(() {
      _utils.globalTearDown("...Ending");
      Get.reset;
    });

    testWidgets('${_config.checking_noneOrderInDB}', (tester) async {
      if (_unitTest == false) {
        await _utils.removeDbCollection(tester, url: ORDERS_URL, delaySeconds: 1);
        await _utils.removeDbCollection(tester, url: PRODUCTS_URL, delaySeconds: 1);
        await _utils.removeDbCollection(tester, url: CART_ITEM_URL, delaySeconds: 1);
      }
      _config.bindingsBuilderMockRepoEmptyDb(execute: _unitTest);
      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.OpenOrderView_NoOrderInDB(tester, DELAY);
    });

    testWidgets('${_config.ordering_fromCartView_tapingTheButtonOrderNow}',
        (tester) async {
      if (!_unitTest) {
        await _utils.addObjectInDb(
          tester,
          object: ProductDataBuilder().ProductFullStaticNoId(),
          delaySeconds: DELAY,
          collectionUrl: PRODUCTS_URL,
        );
      }

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.OrderingFromCartView_TapButtonOrderNow(tester, DELAY);
    });

    testWidgets('${_config.checking_oneOrderInDB}', (tester) async {
      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _utils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        keyOption: DRAWER_ORDER_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
      );

      _utils.checkWidgetsQtdeInOneView(
          widgetView: OrdersView, widgetType: OrderCollapsableTile, widgetQtde: 1);
    });

    testWidgets('${_config.tapping_PageBackButton}', (tester) async {
      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _utils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        keyOption: DRAWER_ORDER_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
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
