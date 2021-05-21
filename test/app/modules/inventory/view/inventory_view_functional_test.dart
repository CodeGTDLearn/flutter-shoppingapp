import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_tests_config.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../inventory_test_config.dart';
import 'inventory_view_tests.dart';

class InventoryViewFunctionalTests {
  bool _unitTests;

  InventoryViewFunctionalTests({String testType}) {
    _unitTests = testType == UNIT_TESTS;
  }

  void functional() {
    // var _tests = Get.put(InventoryViewTests());
    var _tests = InventoryViewTests();
    // var _config = Get.put(InventoryTestConfig());
    var _config = InventoryTestConfig();
    final _viewTestUtils = ViewTestUtils();

    setUpAll(_viewTestUtils.globalSetUpAll);

    tearDownAll(_viewTestUtils.globalTearDownAll);

    setUp(() {
      _config.bindingsBuilderMockedRepo(execute: _unitTests);
      // _tests = Get.put(InventoryViewTests());
    });

    tearDown(Get.reset);

    testWidgets('${_config.OpenInventoryView_NoneOrderInDB}', (tester) async {
      _config.bindingsBuilderMockedRepoEmptyDb(execute: _unitTests);
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      if (!_unitTests) {
        await _viewTestUtils.removeFromDb(tester, url: ORDERS_URL, delaySeconds: 1);
        await _viewTestUtils.removeFromDb(tester, url: PRODUCTS_URL, delaySeconds: 1);
        await _viewTestUtils.removeFromDb(tester, url: CART_ITEM_URL, delaySeconds: 1);
      }

      await _tests.OpenInventoryView_NoOrderInDB(tester, DELAY);
    });

    testWidgets('${_config.checkProductsInInventoryView}', (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      if (!_unitTests) {
        await _viewTestUtils.AddOneProductInDB(
          tester,
          DELAY,
          validTexts: true,
          qtde: 2,
        );
      }

      _unitTests
          ? await _tests.checkProductsInInventoryView(tester, 4)
          : await _tests.checkProductsInInventoryView(tester, 2);
    });

    testWidgets('${_config.DeleteProduct}', (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      var _prods = Get.find<IOverviewService>().getLocalDataAllProducts();
      await _tests.deleteProduct(
        tester,
        initialQtde: 2,
        finalQtde: 1,
        keyTrigger: '$INVENTORY_DELETEITEM_BUTTON_KEY${_prods[0].id}',
      );
    }, skip: true);

    testWidgets('${_config.UpdateProduct}', (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.updateProduct(tester);
    }, skip: true);

    testWidgets('${_config.refreshingInventoryView_checkRefreshIndicator}',
        (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.refreshingInventoryView_checkRefreshIndicator(tester);
    }, skip: true);

    testWidgets('${_config.TapPageBackButton_InInventoryView}', (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.tapingViewBackButton_In_InventoryView(tester);
    }, skip: true);
  }
}
