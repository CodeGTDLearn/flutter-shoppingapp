import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../test_utils/test_utils.dart';
import 'components_test_config.dart';

class ProgresIndicatorTest {
  static void functional() {
    TestUtils seek;

    setUp(() => seek = TestUtils());

    tearDown(() => seek = null);

    List<Product> _products() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    testWidgets('Checking CustomProgrIndicator', (tester) async {
      ComponentsTestConfig().bindingsBuilderMockedRepo();

      await tester.pumpWidget(AppDriver());

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);

      await tester.pump();
      await tester.pump(seek.delay(3));

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsNothing);
      expect(seek.text(NO_PRODUCTS_FOUND_YET), findsNothing);

      expect(seek.text(_products()[0].title.toString()), findsOneWidget);
      expect(seek.text(_products()[1].title.toString()), findsOneWidget);
    });

    testWidgets('Checking CustomProgrIndicator EmptyDB', (tester) async {
      ComponentsTestConfig().bindingsBuilderMockRepoEmptyDb();

      await tester.pumpWidget(AppDriver());

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      expect(seek.type(CircularProgressIndicator), findsOneWidget);
      expect(seek.text(NO_PRODUCTS_FOUND_YET), findsNothing);

      await tester.pump();
      await tester.pump(seek.delay(3));

      expect(seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      expect(seek.type(CircularProgressIndicator), findsNothing);
      expect(seek.text(NO_PRODUCTS_FOUND_YET), findsOneWidget);
    });
  }
}
