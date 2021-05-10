import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
import '../repo/inventory_mocked_repo.dart';

class InventoryAddEditPageTests {
  static void functional() {
    var _seek = TestUtils();

    setUp(() {
      InventoryTestConfig().bindingsBuilder(InventoryMockedRepo());
      _seek = TestUtils();
    });

    tearDown(() => _seek = null);

    Future _openInventoryAddEditView(tester) async {
      OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
      await tester.pumpAndSettle(_seek.delay(2));
      await tester.tap(_seek.key(DRAWER_INVENTORY_OPTION_KEY));
      await tester.pumpAndSettle(_seek.delay(1));
      await tester.tap(_seek.key(INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(InventoryAddEditView), findsOneWidget);
    }

    Future _addAndSaveProductInInventoryAddEditPage(tester,
        {Product product, bool testUsingValidTexts}) async {
      var fakeTitle, fakePrice, fakeDesc, fakeImgUrl, invalidText;

      invalidText = "d";
      fakeTitle = product.title ?? "xxxxxx";
      fakePrice = product.price.toString() ??
          Faker().randomGenerator.decimal(min: 20).toStringAsFixed(2);

      fakeDesc = product.description ?? "xxxxxxxxxxxxxx";
      fakeImgUrl = product.imageUrl ??
          "https://images.freeimages.com/images/large-previews/eae/clothes-3-1466560.jpg";

      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_TITLE), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_PRICE), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_DESCRIPT), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_FIELD_IMAGE_URL), findsOneWidget);
      expect(_seek.text(INVENTORY_ADDEDIT_IMAGE_TITLE), findsOneWidget);

      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_FIELD_TITLE_KEY),
        testUsingValidTexts ? fakeTitle : invalidText,
      );
      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_FIELD_PRICE_KEY),
        testUsingValidTexts ? fakePrice : invalidText,
      );
      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_FIELD_DESCRIPT_KEY),
        testUsingValidTexts ? fakeDesc : invalidText,
      );
      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_FIELD_URL_KEY),
        testUsingValidTexts ? fakeImgUrl : invalidText,
      );

      await tester.pumpAndSettle(_seek.delay(2));

      await tester.tap(_seek.key(INVENTORY_ADDEDIT_SAVEBUTTON_KEY));
      await tester.pump();
      await tester.pump(_seek.delay(2));
    }

    void _expectTestingINValidationMessages(Matcher matcher) {
      expect(_seek.text(INVALID_TITLE_MSG), matcher);
      expect(_seek.text(INVALID_PRICE_MSG), matcher);
      expect(_seek.text(INVALID_DESCR_MSG), matcher);
      expect(_seek.text(INVALID_URL_MSG), matcher);
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
    });

    testWidgets('Open Managed Product AddEdit Page', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _openInventoryAddEditView(tester);
      await _addAndSaveProductInInventoryAddEditPage(
        tester,
        product: ProductsMockedDatasource().product(),
        testUsingValidTexts: true,
      );
    });

    testWidgets('Filling fields with previewImageUrl', (tester) async {
      await tester.pumpWidget(AppDriver());

      await _openInventoryAddEditView(tester);

      await tester.pumpAndSettle(_seek.delay(2));

      _seek.imagesTotal(0);
      await tester.tap(_seek.key(INVENTORY_ADDEDIT_FIELD_URL_KEY));
      await tester.enterText(
        _seek.key(INVENTORY_ADDEDIT_FIELD_URL_KEY),
        "https://images.freeimages"
        ".com/images/large-previews/eae/clothes-3-1466560.jpg",
      );
      await tester.pumpAndSettle(_seek.delay(2));
      await tester.tap(_seek.key(INVENTORY_ADDEDIT_FIELD_DESCRIPT_KEY));
      await tester.pumpAndSettle(_seek.delay(2));
      _seek.imagesTotal(1);
    });

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
    });

    testWidgets('Testing Page BackButton', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pumpAndSettle();

      await _openInventoryAddEditView(tester);

      expect(_seek.type(BackButton), findsOneWidget);
      await tester.tap(_seek.type(BackButton));
      await tester.pumpAndSettle(_seek.delay(2));
      expect(_seek.type(InventoryView), findsOneWidget);
    });

    testWidgets('Open Page with NO products in DB', (tester) async {
      InventoryTestConfig().bindingsBuilder(InventoryMockedRepoFail());

      await tester.pumpWidget(AppDriver());

      OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY.currentState.openDrawer();
      await tester.pumpAndSettle(_seek.delay(1));
      expect(OVERVIEW_PAGE_SCAFFOLD_GLOBALKEY.currentState.isDrawerOpen, isTrue);

      await tester.tap(_seek.key(DRAWER_INVENTORY_OPTION_KEY));
      await tester.pumpAndSettle(_seek.delay(2));
      expect(_seek.type(InventoryView), findsOneWidget);

      await tester.tap(_seek.key(INVENTORY_APPBAR_ADDPRODUCT_BUTTON_KEY));
      await tester.pumpAndSettle(_seek.delay(1));
      expect(_seek.type(InventoryAddEditView), findsOneWidget);
    });
  }
}
