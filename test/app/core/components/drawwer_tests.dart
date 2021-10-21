import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopingapp/app/core/components/keys/drawwer_keys.dart';
import 'package:shopingapp/app/modules/inventory/view/inventory_view.dart';
import 'package:shopingapp/app/modules/overview/core/overview_widget_keys.dart';
import 'package:shopingapp/app/modules/overview/view/overview_view.dart';
import 'package:shopingapp/app_driver.dart' as app;

import '../../../config/tests_properties.dart';
import '../../../utils/dbtest_utils.dart';
import '../../../utils/finder_utils.dart';
import '../../../utils/tests_utils.dart';
import '../../../utils/ui_test_utils.dart';

class DrawwerTests {
  final bool isWidgetTest;
  final FinderUtils finder;
  final UiTestUtils uiTestUtils;
  final DbTestUtils dbTestUtils;
  final TestsUtils testUtils;

  DrawwerTests({
    required this.finder,
    required this.uiTestUtils,
    required this.isWidgetTest,
    required this.dbTestUtils,
    required this.testUtils,
  });

  Future<void> tap_twoDifferent_options_InDrawer(tester) async {
    await uiTestUtils.setTestDeviceScreen(
      tester,
      dx: TEST_SCREEN_SIZE_DX,
      dy: TEST_SCREEN_SIZE_DY,
    );

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

      await tester.tapAt(const Offset(750.0, 100.0)); // on the mask
      await tester.pumpAndSettle(testUtils.delay(DELAY)); // animation done
    }
    uiTestUtils.resetTestDeviceScreen(tester);
  }

  Future<void> open_and_close_drawer(WidgetTester tester) async {
    var height = uiTestUtils.testDeviceScreenHeight(tester);
    var width = uiTestUtils.testDeviceScreenWidth(tester);

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

    await tester.tapAt(Offset(width * 0.90, height * 0.50)); // on the mask
    await tester.pump();
    await tester.pumpAndSettle(testUtils.delay(DELAY)); // animation done

    expect(scaffoldState.isDrawerOpen, isFalse);
  }
}