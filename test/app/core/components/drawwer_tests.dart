import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../config/tests_properties.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';

class DrawwerTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final TestsUtils testUtils;

  DrawwerTests({
    required this.finder,
    required this.uiTestUtils,
    required this.isWidgetTest,
    required this.testUtils,
  });

  Future<void> tap_twoDifferent_options_InDrawer(tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );
    var scaffoldState = DRAWWER_SCAFFOLD_GLOBALKEY.currentState!;

    for (var i = 0; i <= 1; i++) {
      scaffoldState.openDrawer();
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      expect(scaffoldState.isDrawerOpen, isTrue);

      await tester.pumpAndSettle(testUtils.delay(DELAY)); // animation done
      if (i == 0) await tester.tap(finder.key(DRAWER_OVERVIEW_OPTION_KEY));
      if (i == 1) await tester.tap(finder.key(DRAWER_INVENTORY_OPTION_KEY));
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      expect(finder.type(i == 0 ? OverviewView : InventoryView), findsOneWidget);

      await tester.tapAt(Offset(
        uiTestUtils.deviceWidth(tester) * 0.97,
        uiTestUtils.deviceHeight(tester) * 0.97,
      ));
      await tester.pump();
      await tester.pumpAndSettle(testUtils.delay(DELAY));
      expect(scaffoldState.isDrawerOpen, isFalse);
    }
  }

  Future<void> close_drawer_tap_outside(WidgetTester tester) async {
    await uiTestUtils.testInitialization(
      tester,
      isWidgetTest: isWidgetTest,
      appDriver: app.AppDriver(),
    );

    var scaffoldState = DRAWWER_SCAFFOLD_GLOBALKEY.currentState!;
    expect(scaffoldState.isDrawerOpen, isFalse);

    scaffoldState.openDrawer();
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(scaffoldState.isDrawerOpen, isTrue);

    await tester.tapAt(Offset(
      uiTestUtils.deviceWidth(tester) * 0.97,
      uiTestUtils.deviceHeight(tester) * 0.97,
    ));
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY));
    expect(scaffoldState.isDrawerOpen, isFalse);
  }
}
