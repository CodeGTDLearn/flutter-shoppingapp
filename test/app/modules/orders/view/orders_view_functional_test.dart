import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
// import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../orders_test_config.dart';
import 'orders_view_tests.dart';

class OrdersViewFunctionalTest {
  bool _isUnitTest;
  final bool _skipTest = false;

  OrdersViewFunctionalTest({String testType}) {
    _isUnitTest = testType == UNIT_TEST;
  }

  void functional() {
    var _tests = Get.put(OrdersViewTests());
    var _config = Get.put(OrdersTestConfig());
    final _utils = Get.put(ViewTestUtils());

    setUpAll(() => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(execute: _isUnitTest);
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    testWidgets('${_config.checking_noneOrderInDB}', (tester) async {
      if (_isUnitTest == false) {
        await _utils.removeCollectionFromDb(tester, url: ORDERS_URL, delaySeconds: 1);
        await _utils.removeCollectionFromDb(tester, url: PRODUCTS_URL, delaySeconds: 1);
        await _utils.removeCollectionFromDb(tester, url: CART_ITEM_URL, delaySeconds: 1);
      }
      _config.bindingsBuilderMockRepoEmptyDb(execute: _isUnitTest);

      await _tests.OpenOrderView_NoOrderInDB(tester, DELAY, _isUnitTest);
    }, skip: _skipTest);

    testWidgets('${_config.ordering_fromCartView_tapingTheButtonOrderNow}',
        (tester) async {
      if (!_isUnitTest) {
        await _utils.addObjectInDb(
          tester,
          object: ProductDataBuilder().ProductFullStaticNoId(),
          delaySeconds: DELAY,
          collectionUrl: PRODUCTS_URL,
        );
      }

      await _tests.OrderingFromCartView_TapButtonOrderNow(tester, DELAY, _isUnitTest);
    }, skip: _skipTest);

    testWidgets('${_config.checking_oneOrderInDB}', (tester) async {
      // _isUnitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _utils.selectInitialization(tester, _isUnitTest);

      await _utils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        clickedKeyOption: DRAWER_ORDER_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
      );

      _utils.checkWidgetsQtdeInOneView(
          widgetView: OrdersView, widgetType: OrderCollapsableTile, widgetQtde: 1);
    }, skip: _skipTest);

    testWidgets('${_config.tapping_PageBackButton}', (tester) async {
      // _isUnitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _utils.selectInitialization(tester, _isUnitTest);

      await _utils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        clickedKeyOption: DRAWER_ORDER_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
      );

      await _tests.OpenOrderView_TapBackButton(
        tester,
        DELAY,
        from: OrdersView,
        to: OverviewView,
      );
    }, skip: _skipTest);
  }
}
