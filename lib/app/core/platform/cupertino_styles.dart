import 'package:flutter/cupertino.dart';

/*
  ╔════════════════════════════════════════╗
  ║    THE STYLES CLASS DEFINES THE TEXT   ║
  ║ AND COLOR STYLING TO CUSTOMIZE THE APP ║
  ╚════════════════════════════════════════╝
*/
abstract class CupertinoStyles {
  static const TextStyle superiorElevatorListText = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle elevatorType = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 0.8),
    fontSize: 13,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle elevatorModel = TextStyle(
    color: Color(0xFF8E8E93),
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle modalText = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const Color rowDivider = Color(0xFFD9D9D9);

  static const Color scaffoldColor = Color(0xfff0f0f0);

  static const Color loginBackgroundColor = Color(0xffe0e0e0);

  static const Color cursorColor = Color.fromRGBO(0, 122, 255, 1);

  static const Color iconColor = Color.fromRGBO(128, 128, 128, 1);
}