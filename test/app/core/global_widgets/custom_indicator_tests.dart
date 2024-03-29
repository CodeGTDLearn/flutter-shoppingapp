import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/core/components/core_components_keys.dart';
import 'package:shopingapp/app/core/texts/core_messages.dart';
import 'package:shopingapp/app/modules/overview/core/components/custom_grid_item/animated_grid_item.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../config/app_tests_properties.dart';
import '../../../config/utils/finder_utils.dart';
import '../../../config/utils/tests_utils.dart';
import '../../../config/utils/ui_test_utils.dart';

class CustomIndicatorTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestsUtils testUtils;
  final _messages = Get.find<CoreMessages>();
  final _keys = Get.find<CoreComponentsKeys>();

  CustomIndicatorTests({
    required this.finder,
    required this.uiTestUtils,
    required this.isWidgetTest,
    required this.testUtils,
  });

  Future<void> check_custom_progr_indic(WidgetTester tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: false,
    );

    // await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    // expect(finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
    // expect(finder.type(CircularProgressIndicator), findsOneWidget);

    // await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));

    expect(finder.key(_keys.k_circ_prg_indic()), findsNothing);
    expect(finder.type(CircularProgressIndicator), findsNothing);

    expect(finder.type(AnimatedGridItem), findsWidgets);
  }

  Future<void> check_custom_indicator_emptydb(WidgetTester tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: false,
    );

    await tester.pump();
    expect(finder.key(_keys.k_circ_prg_indic()), findsOneWidget);
    expect(finder.type(CircularProgressIndicator), findsOneWidget);

    await tester.pump();
    await tester.pump(testUtils.delay(DELAY + EXTRA_DELAY));

    expect(finder.key(_keys.k_circ_prg_indic()), findsOneWidget);
    expect(finder.type(CircularProgressIndicator), findsNothing);

    expect(finder.type(AnimatedGridItem), findsNothing);

    expect(finder.text(_messages.no_products_yet), findsOneWidget);
  }
}