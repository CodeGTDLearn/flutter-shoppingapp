import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../inventory_test_config.dart';
import 'inventory_view_tests.dart';

class InventoryViewFunctionalTests {
  bool _unitTests;
  final _tests = Get.put(InventoryViewTests());
  final _config = Get.put(InventoryTestConfig());
  final _viewTestUtils = Get.put(ViewTestUtils());

  InventoryViewFunctionalTests({String testType}) {
    _unitTests = testType == UNIT_TEST;
  }

  void functional() {
    setUpAll(() => _viewTestUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _viewTestUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() => _config.bindingsBuilderMockedRepo(execute: _unitTests));

    tearDown(Get.reset);

    testWidgets('${_config.checkInventoryProductsAbsence}', (tester) async {
      if (_unitTests == false) await _cleanDb(tester);
      _config.bindingsBuilderMockedRepoEmptyDb(execute: _unitTests);
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _tests.checkInventoryProductsAbsence(tester, DELAY);
    });

    testWidgets('${_config.checkInventoryProducts}', (tester) async {
      if (!_unitTests) await _addTwoProductInDb(tester);
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      _unitTests
          ? await _tests.checkInventoryProducts(tester, 4)
          : await _tests.checkInventoryProducts(tester, 2);
    });

    testWidgets('${_config.deleteInventoryProduct}', (tester) async {
      var _products;
      // @formatter:off
      if (_unitTests == false) {
        await _cleanDb(tester);
        await _viewTestUtils
            .addObjectInDb(tester,
                object: ProductDataBuilder().ProductFullStaticNoId(),
                delaySeconds: DELAY,
                collectionUrl: PRODUCTS_URL,
                qtdeObjects: 2)
            .then((response) {response.forEach((k, v) => _products.add(v));});
      }
      // @formatter:on

      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      // var _products = Get.find<IOverviewService>().getLocalDataAllProducts();

      await _tests.deleteInventoryProduct(tester,
          initialQtde: 2,
          finalQtde: 1,
          keyTrigger: '$INVENTORY_DELETEITEM_BUTTON_KEY${_products[0].id}',);
    });

    testWidgets('${_config.updateInventoryProduct}', (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.updateInventoryProduct(tester);
    }, skip: true);

    testWidgets('${_config.refreshingInventoryView}', (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.refreshingInventoryView(tester);
    }, skip: true);

    testWidgets('${_config.tapingBackButtonInInventoryView}', (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _viewTestUtils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        keyOption: DRAWER_INVENTORY_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
      );

      await _tests.tapingBackButtonInInventoryView(tester);
    });
  }

  Future _addTwoProductInDb(WidgetTester tester) async {
    return await _viewTestUtils.addObjectInDb(tester,
        object: ProductDataBuilder().ProductFullStaticNoId(),
        delaySeconds: DELAY,
        collectionUrl: PRODUCTS_URL,
        qtdeObjects: 2);
  }

  Future _cleanDb(tester) async {
    await _viewTestUtils.removeDbCollection(tester, url: ORDERS_URL, delaySeconds: 1);
    await _viewTestUtils.removeDbCollection(tester, url: PRODUCTS_URL, delaySeconds: 1);
    await _viewTestUtils.removeDbCollection(tester, url: CART_ITEM_URL, delaySeconds: 1);
  }
}
