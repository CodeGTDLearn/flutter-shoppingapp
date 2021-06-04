import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../inventory_test_config.dart';
import 'inventory_view_tests.dart';

class InventoryViewFunctionalTests {
  bool _unitTests;
  final _tests = Get.put(InventoryViewTests());
  final _config = Get.put(InventoryTestConfig());
  final _testUtils = Get.put(ViewTestUtils());

  InventoryViewFunctionalTests({String testType}) {
    _unitTests = testType == UNIT_TEST;
  }

  void functional() {
    setUpAll(() => _testUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _testUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _testUtils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(execute: _unitTests);
    });

    tearDown(() {
      _testUtils.globalTearDown("...Ending");
      Get.reset;
    });

    testWidgets('${_config.checkingProductsAbsence}', (tester) async {
      if (_unitTests == false) await _cleanDb(tester);
      _config.bindingsBuilderMockedRepoEmptyDb(execute: _unitTests);

      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInventoryProductsAbsence(tester, DELAY);
    }, skip: true);

    testWidgets('${_config.checkingProducts}', (tester) async {
      if (!_unitTests) {
        await _cleanDb(tester);
        await _testUtils.addObjectsInDb(tester,
            qtdeObjects: 2,
            collectionUrl: PRODUCTS_URL,
            object: ProductDataBuilder().ProductFullStaticNoId(),
            delaySeconds: DELAY);
      }

      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      _unitTests
          ? await _tests.checkInventoryProducts(tester, 4)
          : await _tests.checkInventoryProducts(tester, 2);
    }, skip: true);

    testWidgets('${_config.deletingProduct}', (tester) async {
      var _products = [];

      if (_unitTests) {
        _products = ProductsMockedDatasource().products();
      }

      if (!_unitTests) {
        await _cleanDb(tester);
        await _testUtils
            .addObjectsInDb(tester,
                qtdeObjects: 2,
                collectionUrl: PRODUCTS_URL,
                object: ProductDataBuilder().ProductFullStaticNoId(),
                delaySeconds: DELAY)
            .then((value) => _products = value);
      }

      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _tests.deleteInventoryProduct(tester,
          initialQtde: 2,
          finalQtde: 1,
          keyDeleteButton: '$INVENTORY_DELETEITEM_BUTTON_KEY${_products[0].id}',
          widgetTypeToDelete: InventoryItem);
    }, skip: true);

    testWidgets('${_config.updatingProduct}', (tester) async {
      var _products = [];

      if (!_unitTests) {
        await _cleanDb(tester);
        await _testUtils
            .addObjectsInDb(tester,
                qtdeObjects: 2,
                collectionUrl: PRODUCTS_URL,
                object: ProductDataBuilder().ProductFullStaticNoId(),
                delaySeconds: DELAY)
            .then((value) => _products = value);
      }

      var product = _unitTests ? ProductsMockedDatasource().products()[0] : _products[0];

      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.updateInventoryProduct(
        tester,
        updatedTitle: "XXXXXX",
        delaySeconds: DELAY,
        useValidTexts: true,
        productToBeUpdated: product,
        isUnitTest: _unitTests
      );
    });

    testWidgets('${_config.updatingProduct_InvalidTitle}', (tester) async {

    }, skip: true);

    testWidgets('${_config.testingRefreshingView}', (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.refreshingInventoryView(tester);
    }, skip: true);

    testWidgets('${_config.testingBackButtonInView}', (tester) async {
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _testUtils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        keyOption: DRAWER_INVENTORY_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
      );

      await _tests.tapingBackButtonInInventoryView(tester);
    }, skip: true);
  }

  Future _cleanDb(tester) async {
    await _testUtils.removeDbCollection(tester, url: ORDERS_URL, delaySeconds: 1);
    await _testUtils.removeDbCollection(tester, url: PRODUCTS_URL, delaySeconds: 1);
    await _testUtils.removeDbCollection(tester, url: CART_ITEM_URL, delaySeconds: 1);
  }
}
