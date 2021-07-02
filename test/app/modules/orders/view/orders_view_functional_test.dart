import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/modules/orders/components/order_collapsable_tile.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../config/app_tests_config.dart';
import '../../../../config/orders_test_config.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'orders_tests.dart';

class OrdersViewFunctionalTest {
  bool _isWidgetTest;
  final bool _skipTest = false;
  final _config = Get.put(OrdersTestConfig());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _utils = Get.put(TestUtils());

  OrdersViewFunctionalTest({String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OrdersTests(
      testUtils: _utils,
      uiTestUtils: _uiUtils,
      isWidgetTest: _isWidgetTest,
      dbTestUtils: _dbUtils,
    ));

    setUpAll(() => _uiUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _uiUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _uiUtils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDown(() => _uiUtils.globalTearDown("...Ending"));

    testWidgets('${_config.check_oneOrderInDB}', (tester) async {
      if (!_isWidgetTest) {
        await _dbUtils.removeAllCollections(tester, delaySeconds: DELAY, dbName: DB_NAME);
      }
      _config.bindingsBuilderMockRepoEmptyDb(isWidgetTest: _isWidgetTest);
      await _tests.checkOrders_OrdersAbsence(tester, DELAY);
    }, skip: _skipTest);

    testWidgets('${_config.ordering_InCartView_tapOrderNowBtn}', (tester) async {
      await _tests.OrderingFromCartView_TapButtonOrderNow(tester, DELAY);
    }, skip: _skipTest);

    testWidgets('${_config.check_oneOrderInDB}', (tester) async {
      await _uiUtils.testInitialization(
        tester,
        isWidgetTest: _isWidgetTest,
        appDriver: app.AppDriver(),
      );

      await _uiUtils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        optionKey: DRAWER_ORDER_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
      );

      _uiUtils.checkWidgetsQtdeInOneView(
        widgetView: OrdersView,
        widgetType: OrderCollapsableTile,
        widgetQtde: 1,
      );
    }, skip: _skipTest);

    testWidgets('${_config.tap_ViewBackButton}', (tester) async {
      await _tests.tapingBackButtonInOrdersView(
        tester,
        DELAY,
        from: OrdersView,
        to: OverviewView,
      );
    }, skip: _skipTest);
  }
}
