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
import 'package:shopingapp/app_driver.dart' as app;

import '../../../../app_tests_config.dart';
import '../../../../data_builders/product_databuilder.dart';
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

    testWidgets('${_config.edit_add_product_via_form}', (tester) async {
      await _tests.addProductFillingForm(tester);
      }, skip: _skipTest);

    testWidgets('${_config.edit_preview_url_in_form}', (tester) async {
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
    }, skip: true);
    // });

    testWidgets('${_config.edit_fill_form_invalid}', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _tests.openInventoryEditView(tester);
      await _tests.addProductFillingFormInInventoryEditView(
        tester,
        product: ProductsMockedDatasource().product(),
        testUsingValidTexts: false,
      );

      _tests.expectTestingINValidationMessages(findsOneWidget);

      expect(_testUtils.type(InventoryEditView), findsOneWidget);
    }, skip: true);

    testWidgets('${_config.edit_back_button}', (tester) async {
      await _tests.tapBackButtonInInventoryEditView(tester);
    }, skip: _skipTest);
  }
}
