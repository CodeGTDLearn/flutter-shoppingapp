// import 'package:flutter/material.dart';
// import 'package:flutter_reversi/app_driver.dart';
// import 'package:flutter_reversi/core/app_widget_keys.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// // WIDGET TEST: it is an "Unit Test for Specific Widgets"
// void main() {
//   testWidgets('Widget Testing', (WidgetTester tester) async {
//     //
//     // 1) Select the WIDGET to test
//     await tester.pumpWidget(AppDriver());
//
//     // 2) find the ITEM to test + confirm this finding
//     var _textField = find.byKey(Key(K01));
//     expect(_textField, findsOneWidget);
//
//     // 3) entra o TEXTO p/ TEST + CONFIRMA
//     await tester
//         .enterText(_textField, 'Ab')
//         .then((value) => expect(find.text('Ab'), findsOneWidget));
//
//     // 4) ACIONA BUTTON
//     // 4.a) Find BUTTON(via KEY) + CONFIRMA
//     var button = find.byKey(Key(K03));
//     expect(button, findsOneWidget);
//
//     // 4.b) Tap Button + ReBuild 1 frame(Pump) + Check Result
//     tester
//         .tap(button)
//         .then((value) => tester.pump())
//         .then((value) => expect(find.text('bA'), findsOneWidget));
//   });
// }
