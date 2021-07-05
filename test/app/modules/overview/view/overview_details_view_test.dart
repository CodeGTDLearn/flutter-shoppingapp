import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview.dart';
import 'package:shopingapp/app/modules/cart/controller/cart_controller.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/controller/overview_controller.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/repo/i_overview_repo.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../../config/app_tests_config.dart';
import '../../../../config/overview_test_config.dart';
import '../../../../utils/db_test_utils.dart';
import '../../../../utils/test_utils.dart';
import '../../../../utils/ui_test_utils.dart';
import 'overview_tests.dart';

class OverviewDetailsViewTest {
  bool _isWidgetTest;
  final bool _skipTest = false;
  TestUtils _utils = Get.put(TestUtils());
  final UiTestUtils _uiUtils = Get.put(UiTestUtils());
  final DbTestUtils _dbUtils = Get.put(DbTestUtils());
  final OverviewTestConfig _config = Get.put(OverviewTestConfig());

  OverviewDetailsViewTest({String testType}) {
    _isWidgetTest = testType == WIDGET_TEST;
  }

  void functional() {
    final _tests = Get.put(OverviewTests(
        testUtils: _utils,
        uiTestUtils: _uiUtils,
        dbTestUtils: _dbUtils,
        isWidgetTest: _isWidgetTest));

    setUpAll(() => _utils.globalSetUpAll(_tests.runtimeType.toString()));

    tearDownAll(() => _utils.globalTearDownAll(_tests.runtimeType.toString()));

    setUp(() {
      _utils.globalSetUp("Starting...");
      _config.bindingsBuilder();
    });

    tearDown(() => _utils.globalTearDown("...Ending"));

    List<Product> _products() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    testWidgets('${_config.click_product_check_details_texts}', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var keyProduct1 = _utils.key("$OVERVIEW_ITEM_DETAILS_PAGE_KEY\0");

      await tester.pumpAndSettle(_utils.delay(3));
      // @formatter:off
      tester
          .tap(keyProduct1)
          .then((value) => tester.pumpAndSettle(_utils.delay(1)))
          .then((value) {
        expect(_utils.text(_products()[0].title.toString()), findsOneWidget);
        expect(_utils.text('\$${_products()[0].price}'), findsOneWidget);
        expect(_utils.text(_products()[0].description.toString()), findsOneWidget);
      });
      // @formatter:on
    }, skip: _skipTest);

    testWidgets('${_config.click_product_check_details_image}', (tester) async {
      await tester.pumpWidget(AppDriver());
      await tester.pump();

      var keyProduct1 = _utils.key("$OVERVIEW_ITEM_DETAILS_PAGE_KEY\0");

      await tester.tap(keyProduct1);

      // check if the page has changed
      await tester.pumpAndSettle(_utils.delay(3));
      expect(_utils.text(_products()[0].title.toString()), findsOneWidget);

      _utils.checkImageTotalOnAView(1);
    }, skip: _skipTest);
  }
}
