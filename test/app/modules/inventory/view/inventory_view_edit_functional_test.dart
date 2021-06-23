import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/inventory/inventory_add_edit.dart';
import 'package:shopingapp/app/modules/inventory/components/inventory_item.dart';
import 'package:shopingapp/app/modules/inventory/core/inventory_keys.dart';
import 'package:shopingapp/app/modules/inventory/core/messages/field_form_validation_provided.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_edit_view.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../app_tests_config.dart';
import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/test_utils.dart';
import '../../../../test_utils/view_test_utils.dart';
import '../inventory_test_config.dart';
import 'inventory_view_tests.dart';

class InventoryViewEditFunctionalTest {
  bool _isWidgetTest;
  final bool _skipTest = false;
  final _config = Get.put(InventoryTestConfig());
  final _viewTestUtils = Get.put(ViewTestUtils());
  var _testUtils = Get.put(TestUtils());

  InventoryViewEditFunctionalTest({String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(InventoryViewTests(
      testType: _isWidgetTest,
      testUtils: _testUtils,
      viewTestUtils: _viewTestUtils,
    ));

    setUpAll(() => _viewTestUtils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _viewTestUtils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _viewTestUtils.globalSetUp("Starting...");
      _config.bindingsBuilderMockedRepo(testType: _isWidgetTest);
      _testUtils = Get.put(TestUtils());
    });

    tearDown(() => _viewTestUtils.globalTearDown("...Ending"));

    testWidgets('${_config.edit_add_product}', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _tests.openInventoryEditView(tester);

      await _tests.addProductInInventoryEditPage(
        tester,
        product: ProductsMockedDatasource().product(),
        testUsingValidTexts: true,
      );

      expect(_testUtils.type(InventoryView), findsOneWidget);
      expect(_testUtils.type(InventoryItem), findsNWidgets(5));

      expect(_testUtils.type(BackButton), findsOneWidget);
      await tester.tap(_testUtils.type(BackButton));
      await tester.pumpAndSettle(_testUtils.delay(1));

      expect(_testUtils.type(OverviewView), findsOneWidget);
    }, skip: _skipTest);

    testWidgets('${_config.edit_open_view}', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _tests.openInventoryEditView(tester);
      await _tests.addProductInInventoryEditPage(
        tester,
        product: ProductsMockedDatasource().product(),
        testUsingValidTexts: true,
      );
    }, skip: _skipTest);

    testWidgets('${_config.edit_filling_view}', (tester) async {
      await tester.pumpWidget(AppDriver());

      await _tests.openInventoryEditView(tester);

      await tester.pumpAndSettle(_testUtils.delay(2));

      _testUtils.imagesTotal(0);
      await tester.tap(_testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY));
      await tester.enterText(
        _testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY),
        "https://images.freeimages"
        ".com/images/large-previews/eae/clothes-3-1466560.jpg",
      );
      await tester.pumpAndSettle(_testUtils.delay(2));
      await tester.tap(_testUtils.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY));
      await tester.pumpAndSettle(_testUtils.delay(2));
      _testUtils.imagesTotal(1);
    }, skip: _skipTest);

    testWidgets('${_config.edit_filling_view_invalid}', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _tests.openInventoryEditView(tester);
      await _tests.addProductInInventoryEditPage(
        tester,
        product: ProductsMockedDatasource().product(),
        testUsingValidTexts: false,
      );

      _tests.expectTestingINValidationMessages(findsOneWidget);

      expect(_testUtils.type(InventoryEditView), findsOneWidget);
    }, skip: _skipTest);

    testWidgets('${_config.edit_back_button}', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _tests.openInventoryEditView(tester);

      expect(_testUtils.type(BackButton), findsOneWidget);
      await tester.tap(_testUtils.type(BackButton));
      await tester.pumpAndSettle(_testUtils.delay(2));
      expect(_testUtils.type(InventoryView), findsOneWidget);
    }, skip: _skipTest);

    testWidgets('${_config.edit_checking_ProductsAbsence}', (tester) async {
      InventoryTestConfig().bindingsBuilderMockedRepoEmptyDb(testType: true);

      await tester.pumpWidget(AppDriver());

      DRAWWER_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
      await tester.pumpAndSettle(_testUtils.delay(1));
      expect(DRAWWER_SCAFFOLD_GLOBALKEY.currentState.isDrawerOpen, isTrue);

      await tester.tap(_testUtils.key(DRAWER_INVENTORY_OPTION_KEY));
      await tester.pumpAndSettle(_testUtils.delay(2));
      expect(_testUtils.type(InventoryView), findsOneWidget);

      await tester.tap(_testUtils.key(INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY));
      await tester.pumpAndSettle(_testUtils.delay(1));
      expect(_testUtils.type(InventoryEditView), findsOneWidget);
    }, skip: _skipTest);
  }
}
