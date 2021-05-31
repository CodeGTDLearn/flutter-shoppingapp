import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/properties/app_urls.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
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
  final _testUtils = Get.put(ViewTestUtils());

  InventoryViewFunctionalTests({String testType}) {
    _unitTests = testType == UNIT_TEST;
  }

  void functional() {
    setUpAll(() => _testUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _testUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _testUtils.globalSetUp("INICIA TEST");
      _config.bindingsBuilderMockedRepo(execute: _unitTests);
    });

    tearDown(() {
      _testUtils.globalTearDown("FINALIZA TEST");
      Get.reset;
    });

    testWidgets('${_config.checkInventoryProductsAbsence}', (tester) async {
      if (_unitTests == false) await _cleanDb(tester);
      _config.bindingsBuilderMockedRepoEmptyDb(execute: _unitTests);
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _tests.checkInventoryProductsAbsence(tester, DELAY);
    });

    testWidgets('${_config.checkInventoryProducts}', (tester) async {
      if (!_unitTests) await _addProductsInDb(tester, qtdeObjects: 2);
      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      _unitTests
          ? await _tests.checkInventoryProducts(tester, 4)
          : await _tests.checkInventoryProducts(tester, 2);
    });

    testWidgets('${_config.deleteInventoryProduct}', (tester) async {
      var _products = [];

      if (_unitTests) {
        Get.find<IOverviewService>().getProducts().then((value) => _products = value);
      }

      if (!_unitTests) {
        await _cleanDb(tester);
        await _addProductsInDb(tester, qtdeObjects: 2).then((value) => _products = value);
      }

      _unitTests ? await tester.pumpWidget(app.AppDriver()) : app.main();

      await _tests.deleteInventoryProduct(tester,
          initialQtde: 2,
          finalQtde: 1,
          keyDeleteButton: '$INVENTORY_DELETEITEM_BUTTON_KEY${_products[0].id}',
          widgetTypeToDelete: InventoryItem);
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

      await _testUtils.openDrawerAndClickAnOption(
        tester,
        delaySeconds: DELAY,
        keyOption: DRAWER_INVENTORY_OPTION_KEY,
        scaffoldGlobalKey: DRAWWER_SCAFFOLD_GLOBALKEY,
      );

      await _tests.tapingBackButtonInInventoryView(tester);
    });
  }

  Future<List<Product>> _addProductsInDb(
    tester, {
    int qtdeObjects,
  }) async {
    var listReturn = <Product>[];

    qtdeObjects ??= 1;
    for (var i = 1; i <= qtdeObjects; i++) {
      await _testUtils
          .addObjectInDb(tester,
              object: ProductDataBuilder().ProductFullStaticNoId(),
              delaySeconds: DELAY,
              collectionUrl: PRODUCTS_URL)
          .then((object) {
        listReturn.add(object);
      });
    }

    return Future.value(listReturn);
  }

  Future _cleanDb(tester) async {
    await _testUtils.removeDbCollection(tester, url: ORDERS_URL, delaySeconds: 1);
    await _testUtils.removeDbCollection(tester, url: PRODUCTS_URL, delaySeconds: 1);
    await _testUtils.removeDbCollection(tester, url: CART_ITEM_URL, delaySeconds: 1);
  }
}
