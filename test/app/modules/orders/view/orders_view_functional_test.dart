import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/modules/orders/view/orders_view.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';

import '../../../../config/app_tests_config.dart';
import '../../../../config/orders_test_config.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'orders_tests.dart';

class OrdersViewTest {
  late bool _isWidgetTest;
  final _utils = Get.put(TestUtils());
  final _uiUtils = Get.put(UiTestUtils());
  final _dbUtils = Get.put(DbTestUtils());
  final _config = Get.put(OrdersTestConfig());

  OrdersViewTest({required String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OrdersTests(
      testUtils: _utils,
      dbTestUtils: _dbUtils,
      uiTestUtils: _uiUtils,
      isWidgetTest: _isWidgetTest,
    ));

    setUpAll(() async => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(isWidgetTest: _isWidgetTest);
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    testWidgets(_config.check_emptyOrderCollection, (tester) async {
      if (!_isWidgetTest) {
        await _dbUtils.cleanDb(dbUrl: TESTDB_URL, dbName: TESTDB_NAME);
      }
      _config.bindingsBuilderMockRepoEmptyDb(isWidgetTest: _isWidgetTest);

      await _tests.check_emptyOrderCollection(tester, DELAY);
    });

    testWidgets(_config.ordering_InCartView_tapOrderNowBtn, (tester) async {
      await _tests.Ordering_InCartView_TapOrderNowButton(tester, DELAY);
    });

    testWidgets(_config.check_Orders_with_oneOrderInDB, (tester) async {
      await _tests.check_oneOrderInDB(tester, DELAY);
    });

    testWidgets(_config.tap_ViewBackButton, (tester) async {
      await _tests.tappingBackButtonInOrdersView(
        tester,
        DELAY,
        from: OrdersView,
        to: OverviewView,
      );
    });
  }
}
