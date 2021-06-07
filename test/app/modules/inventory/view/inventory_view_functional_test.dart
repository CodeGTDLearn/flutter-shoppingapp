import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';
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
  bool _unitTest;
  final _tests = Get.put(InventoryViewTests());
  final _config = Get.put(InventoryTestConfig());
  final _testUtils = Get.put(ViewTestUtils());

  InventoryViewFunctionalTests({String testType}) {
    _unitTest = testType == UNIT_TEST;
  }

  void functional() {
    setUpAll(() => _testUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _testUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _testUtils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(execute: _unitTest);
    });

    tearDown(() {
      _testUtils.globalTearDown("...Ending");
      Get.reset;
    });

    testWidgets('${_config.checkingProductsAbsence}', (tester) async {
      if (_unitTest == false) await _cleanDb(tester);
      _config.bindingsBuilderMockedRepoEmptyDb(execute: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.checkInventoryProductsAbsence(tester, DELAY);
    }, skip: true);

    testWidgets('${_config.checkingProducts}', (tester) async {
      if (!_unitTest) {
        await _cleanDb(tester);
        await _testUtils.addObjectsInDb(tester,
            qtdeObjects: 2,
            collectionUrl: PRODUCTS_URL,
            object: ProductDataBuilder().ProductFullStaticNoId(),
            delaySeconds: DELAY);
      }

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      _unitTest
          ? await _tests.checkInventoryProducts(tester, 4)
          : await _tests.checkInventoryProducts(tester, 2);
    }, skip: true);

    testWidgets('${_config.deletingProduct}', (tester) async {
      var product = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.deleteInventoryProduct(tester,
          initialQtde: 2,
          finalQtde: 1,
          keyDeleteButton: '$INVENTORY_DELETEITEM_BUTTON_KEY${product.id}',
          widgetTypeToDelete: InventoryItem);
    }, skip: true);

    testWidgets('${_config.updatingProduct}', (tester) async {
      var product = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.updateInventoryProduct(
        tester,
        fieldInputText: "XXXXXX",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        productToUpdate: product,
        isUnitTest: _unitTest,
      );
    });

    testWidgets('${_config.updatingProduct_InvalidTitle}', (tester) async {
      var productToUpdate = await _testProduct(tester, unitTest: _unitTest);

      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.updateInventoryProduct(
        tester,
        fieldInputText: "xxx",
        fieldKey: INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY,
        fieldValidationMessage: INVALID_MSG_SIZE_05_10,
        productToUpdate: productToUpdate,
        isUnitTest: _unitTest,
      );
    });

    testWidgets('${_config.testingRefreshingView}', (tester) async {
      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();
      await _tests.refreshingInventoryView(tester);
    }, skip: true);

    testWidgets('${_config.testingBackButtonInView}', (tester) async {
      _unitTest ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _testUtils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        keyOption: DRAWER_INVENTORY_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
      );

      await _tests.tapingBackButtonInInventoryView(tester);
    }, skip: true);
  }

  Future<dynamic> _testProduct(tester, {bool unitTest}) async {
    var _product;

    if (!unitTest) {
      await _cleanDb(tester);
      await _testUtils
          .addObjectsInDb(tester,
              qtdeObjects: 2,
              collectionUrl: PRODUCTS_URL,
              object: ProductDataBuilder().ProductFullStaticNoId(),
              delaySeconds: DELAY)
          .then((value) => _product = value[0]);
    }

    return unitTest ? ProductsMockedDatasource().products()[0] : _product;
  }

  Future _cleanDb(tester) async {
    await _testUtils.removeDbCollection(tester, url: ORDERS_URL, delaySeconds: 1);
    await _testUtils.removeDbCollection(tester, url: PRODUCTS_URL, delaySeconds: 1);
    await _testUtils.removeDbCollection(tester, url: CART_ITEM_URL, delaySeconds: 1);
  }
}
