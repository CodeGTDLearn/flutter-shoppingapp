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
import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../orders_test_config.dart';
import 'orders_view_tests.dart';

class OrdersViewFunctionalTest {
  bool _isWidgetTest;
  final bool _skipTest = false;
  final _config = Get.put(OrdersTestConfig());
  final _viewUtils = Get.put(ViewTestUtils());
  final _testUtils = Get.put(TestUtils());

  OrdersViewFunctionalTest({String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {

    final _tests = Get.put(OrdersViewTests(
      testType: _isWidgetTest,
      testUtils: _testUtils,
      viewTestUtils: _viewUtils,
    ));

    setUpAll(() => _viewUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _viewUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _viewUtils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(testType: _isWidgetTest);
    });

    tearDown(() => _viewUtils.globalTearDown("...Ending"));

    testWidgets('${_config.checking_noneOrderInDB}', (tester) async {
      if (_isWidgetTest == false) {
        await _viewUtils.removeCollectionFromDb(tester, url: ORDERS_URL, delaySeconds: 1);
        await _viewUtils.removeCollectionFromDb(tester,
            url: PRODUCTS_URL, delaySeconds: 1);
        await _viewUtils.removeCollectionFromDb(tester,
            url: CART_ITEM_URL, delaySeconds: 1);
      }
      _config.bindingsBuilderMockRepoEmptyDb(testType: _isWidgetTest);

      await _tests.OpenOrderView_NoOrderInDB(tester, DELAY);
    }, skip: _skipTest);

    testWidgets('${_config.ordering_fromCartView_tapingTheButtonOrderNow}',
        (tester) async {
      if (!_isWidgetTest) {
        await _viewUtils.addObjectInDb(
          tester,
          object: ProductDataBuilder().ProductFullStaticNoId(),
          delaySeconds: DELAY,
          collectionUrl: PRODUCTS_URL,
        );
      }

      await _tests.OrderingFromCartView_TapButtonOrderNow(tester, DELAY);
    }, skip: _skipTest);

    testWidgets('${_config.checking_oneOrderInDB}', (tester) async {
      await _viewUtils.testsInitialization(
        tester,
        testType: _isWidgetTest,
        appDriver: app.AppDriver(),
      );

      await _viewUtils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        clickedKeyOption: DRAWER_ORDER_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
      );

      _viewUtils.checkWidgetsQtdeInOneView(
          widgetView: OrdersView, widgetType: OrderCollapsableTile, widgetQtde: 1);
    }, skip: _skipTest);

    testWidgets('${_config.tapping_ViewBackButton}', (tester) async {
      await _viewUtils.testsInitialization(
        tester,
        testType: _isWidgetTest,
        appDriver: app.AppDriver(),
      );

      await _viewUtils.openDrawerAndClickAnOption(
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
