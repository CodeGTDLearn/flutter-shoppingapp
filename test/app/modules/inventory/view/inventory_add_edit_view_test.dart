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
import 'package:shopingapp/app/modules/inventory/view/inventory_add_edit_view.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../mocked_datasource/products_mocked_datasource.dart';
import '../../../../test_utils/test_utils.dart';
import '../inventory_test_config.dart';

class InventoryAddEditViewTest {
  static void functional() {
    final _skipTest = false;
    var _seek = Get.put(TestUtils());

    setUp(() {
      InventoryTestConfig().bindingsBuilderMockedRepo(execute: true);
      _seek = TestUtils();
    });

    tearDown(() => _seek = null);

    Future _openInventoryAddEditView(tester) async {
      DRAWWER_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
      await tester.pumpAndSettle(_seek.delay(2));
      await tester.tap(_seek.key(DRAWER_INVENTORY_OPTION_KEY));
      await tester.pumpAndSettle(_seek.delay(1));
      await tester.tap(_seek.key(INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(InventoryAddEditView), findsOneWidget);
    }

    Future _addAndSaveProductInInventoryAddEditPage(
      tester, {
      Product product,
      bool testUsingValidTexts,
    }) async {
      var validTitle, validPrice, validDesc, validImgUrl, invalidText;

      invalidText = "d";
      validTitle = product.title ?? "xxxxxx";
      validPrice = product.price.toString() ??
          Faker().randomGenerator.decimal(min: 20).toStringAsFixed(2);

      validDesc = product.description ?? "xxxxxxxxxxxxxx";
      validImgUrl = product.imageUrl ??
          "https://images.freeimages.com/images/large-previews/eae/clothes-3-1466560.jpg";

      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_TITLE), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_PRICE), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_DESCRIPT), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_IMAGE_URL), findsOneWidget);

      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_TITLE_KEY),
        testUsingValidTexts ? validTitle : invalidText,
      );
      //Price is blocked against INVALID CONTENT, so there is no need to test it.
      // await tester.enterText(
      //   _seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_PRICE_KEY),
      //   testUsingValidTexts ? validPrice : invalidText,
      // );
      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY),
        testUsingValidTexts ? validDesc : invalidText,
      );
      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY),
        testUsingValidTexts ? validImgUrl : invalidText,
      );

      await tester.pumpAndSettle(_seek.delay(2));

      await tester.tap(_seek.key(INVENTORY_ADDEDIT_VIEW_SAVEBUTTON_KEY));
      await tester.pump();
      await tester.pump(_seek.delay(2));
    }

    void _expectTestingINValidationMessages(Matcher matcher) {
      expect(_seek.text(SIZE_05_INVALID_MSG), matcher);
      // expect(_seek.text(PRICE_INVALID_MSG), matcher);
      expect(_seek.text(SIZE_10_INVALID_MSG), matcher);
      expect(_seek.text(URL_INVALID_MSG), matcher);
    }

    testWidgets('Adding a product', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _openInventoryAddEditView(tester);

      await _addAndSaveProductInInventoryAddEditPage(
        tester,
        product: ProductsMockedDatasource().product(),
        testUsingValidTexts: true,
      );

      expect(_seek.type(InventoryView), findsOneWidget);
      expect(_seek.type(InventoryItem), findsNWidgets(5));

      expect(_seek.type(BackButton), findsOneWidget);
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(1));

      expect(_seek.type(OverviewView), findsOneWidget);
    }, skip: _skipTest);

    testWidgets('Open Managed Product AddEdit Page', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _openInventoryAddEditView(tester);
      await _addAndSaveProductInInventoryAddEditPage(
        tester,
        product: ProductsMockedDatasource().product(),
        testUsingValidTexts: true,
      );
    }, skip: _skipTest);

    testWidgets('Filling fields with previewImageUrl', (tester) async {
      await tester.pumpWidget(AppDriver());

      await _openInventoryAddEditView(tester);

      await tester.pumpAndSettle(_seek.delay(2));

      _seek.imagesTotal(0);
      await tester.tap(_seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY));
      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_URL_KEY),
        "https://images.freeimages"
        ".com/images/large-previews/eae/clothes-3-1466560.jpg",
      );
      await tester.pumpAndSettle(_seek.delay(2));
      await tester.tap(_seek.key(INVENTORY_ADDEDIT_VIEW_FIELD_DESCRIPT_KEY));
      await tester.pumpAndSettle(_seek.delay(2));
      _seek.imagesTotal(1);
    }, skip: _skipTest);

    testWidgets('Filling fields testing INValidation', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _openInventoryAddEditView(tester);
      await _addAndSaveProductInInventoryAddEditPage(
        tester,
        product: ProductsMockedDatasource().product(),
        testUsingValidTexts: false,
      );

      _expectTestingINValidationMessages(findsOneWidget);

      expect(_seek.type(InventoryAddEditView), findsOneWidget);
    }, skip: _skipTest);

    testWidgets('Testing Page BackButton', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _openInventoryAddEditView(tester);

      expect(_seek.type(BackButton), findsOneWidget);
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(2));
      expect(_seek.type(InventoryView), findsOneWidget);
    }, skip: _skipTest);

    testWidgets('Open Page with NO products in DB', (tester) async {
      InventoryTestConfig().bindingsBuilderMockedRepoEmptyDb(execute: true);

      await tester.pumpWidget(AppDriver());

      DRAWWER_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
      await tester.pumpAndSettle(_seek.delay(1));
      expect(DRAWWER_SCAFFOLD_GLOBALKEY.currentState.isDrawerOpen, isTrue);

      await tester.tap(_seek.key(DRAWER_INVENTORY_OPTION_KEY));
      await tester.pumpAndSettle(_seek.delay(2));
      expect(_seek.type(InventoryView), findsOneWidget);

      await tester.tap(_seek.key(INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(InventoryAddEditView), findsOneWidget);
    }, skip: _skipTest);
  }
}
