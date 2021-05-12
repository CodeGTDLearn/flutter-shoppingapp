import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_utils.dart';

class ViewTestUtils {
  final _seek = TestUtils();

  Future navigationBetweenViews(
    WidgetTester tester, {
    int delaySeconds,
    Type from,
    Type to,
    Type widgetTrigger,
  }) async {
    expect(_seek.type(from), findsOneWidget);
    await tester.tap(_seek.type(widgetTrigger));
    // await tester.pump();
    await tester.pumpAndSettle(_seek.delay(delaySeconds));
    expect(_seek.type(to), findsOneWidget);
  }

  Future tapButtonWithResult(
    WidgetTester tester, {
    int delaySeconds,
    String keyWidgetTrigger,
    Type typeWidgetResult,
  }) async {
    await tester.tap(_seek.key(keyWidgetTrigger));
    await tester.pump();
    await tester.pump(_seek.delay(2));
    await tester.pumpAndSettle();
    expect(_seek.type(typeWidgetResult), findsWidgets);
  }

  Future openDrawerAndClickAnOption(
    WidgetTester tester, {
    int delaySeconds,
    String keyOption,
    GlobalKey<ScaffoldState> scaffoldGlobalKey,
  }) async {
    await tester.pumpAndSettle();
    scaffoldGlobalKey.currentState.openDrawer();
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(_seek.delay(delaySeconds));
    await tester.tap(_seek.key(keyOption));
    await tester.pumpAndSettle();
    await tester.pump(_seek.delay(delaySeconds));
  }

  void checkWidgetsQtdeInOneView({
    Type widgetView,
    Type widgetElement,
    int widgetQtde,
  }) {
    expect(_seek.type(widgetView), findsOneWidget);
    expect(
      _seek.type(widgetElement),
      widgetQtde == 0 ? findsNothing : findsWidgets,
    );
  }
}
