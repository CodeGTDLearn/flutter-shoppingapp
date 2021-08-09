import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';
import 'package:shopingapp/app/modules/overview/service/i_overview_service.dart';
import 'package:shopingapp/app_driver.dart';

import '../../../config/bindings/components_test_bindings.dart';
import '../../../utils/test_utils.dart';

class ProgresIndicatorTest {
  static void functional() {
    late TestUtils _seek;

    setUp(() => _seek = Get.put(TestUtils(), tag: 'tempInstance'));

    tearDown(() => Get.delete(tag: 'tempInstance'));

    List<Product> _products() {
      return Get.find<IOverviewService>().getLocalDataAllProducts();
    }

    testWidgets('Checking CustomProgrIndicator', (tester) async {
      ComponentsTestBindings().bindingsBuilderMockedRepo();

      await tester.pumpWidget(AppDriver());

      expect(_seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);

      await tester.pump();
      await tester.pump(_seek.delay(3));

      expect(_seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsNothing);
      expect(_seek.text(NO_PRODUCTS_FOUND_YET), findsNothing);

      expect(_seek.text(_products()[0].title.toString()), findsOneWidget);
      expect(_seek.text(_products()[1].title.toString()), findsOneWidget);
    });

    testWidgets('Checking CustomProgrIndicator EmptyDB', (tester) async {
      ComponentsTestBindings().bindingsBuilderMockRepoEmptyDb();

      await tester.pumpWidget(AppDriver());

      expect(_seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      expect(_seek.type(CircularProgressIndicator), findsOneWidget);
      expect(_seek.text(NO_PRODUCTS_FOUND_YET), findsNothing);

      await tester.pump();
      await tester.pump(_seek.delay(3));

      expect(_seek.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
      expect(_seek.type(CircularProgressIndicator), findsNothing);
      expect(_seek.text(NO_PRODUCTS_FOUND_YET), findsOneWidget);
    });
  }
}
