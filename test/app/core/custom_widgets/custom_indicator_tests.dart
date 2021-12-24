import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/keys/custom_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/modules/overview/core/custom_grid_item/animated_grid_item.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../config/app_tests_properties.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';

class CustomIndicatorTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestsUtils testUtils;

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

    expect(finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsNothing);
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
    expect(finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
    expect(finder.type(CircularProgressIndicator), findsOneWidget);

    await tester.pump();
    await tester.pump(testUtils.delay(DELAY + EXTRA_DELAY));

    expect(finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
    expect(finder.type(CircularProgressIndicator), findsNothing);

    expect(finder.type(AnimatedGridItem), findsNothing);

    expect(finder.text(NO_PRODUCTS_FOUND_YET), findsOneWidget);
  }
}