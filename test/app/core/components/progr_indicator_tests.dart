import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/components/keys/progres_indicator_keys.dart';
import 'package:shopingapp/app/core/texts_icons_provider/messages.dart';
import 'package:shopingapp/app/modules/overview/components/overview_grid_item.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../config/tests_properties.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';

class ProgrIndicatorTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestsUtils testUtils;

  ProgrIndicatorTests({
    required this.finder,
    required this.uiTestUtils,
    required this.isWidgetTest,
    required this.testUtils,
  });

  Future<void> check_custom_progr_indic(WidgetTester tester) async {
    await uiTestUtils.testInitialization222(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
      applyDelay: false,
    );
    await tester.pump();
    expect(finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
    expect(finder.type(CircularProgressIndicator), findsOneWidget);

    await tester.pump();
    await tester.pump(testUtils.delay(DELAY));

    expect(finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsNothing);
    expect(finder.type(CircularProgressIndicator), findsNothing);
    expect(finder.type(OverviewGridItem), findsWidgets);
  }

  Future<void> check_custom_progr_indic_emptydb(WidgetTester tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    expect(finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsOneWidget);
    expect(finder.type(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    await tester.pump(testUtils.delay(DELAY));

    // expect(finder.type(CircularProgressIndicator), findsNothing);
    // expect(finder.key(CUSTOM_CIRC_PROGR_INDICATOR_KEY), findsNothing);
    expect(finder.text(NO_PRODUCTS_FOUND_YET), findsOneWidget);
    expect(finder.type(OverviewGridItem), findsNothing);
  }
}
