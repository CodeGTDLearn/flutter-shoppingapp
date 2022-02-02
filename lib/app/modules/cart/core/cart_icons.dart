import 'package:flutter/material.dart';

class CartIcons {
  final _CLEAR_ALL = Icon(Icons.clear_all);
  final _DISMISSING = Icon(Icons.delete, color: Colors.white, size: 40);

  Icon ico_clear() => _CLEAR_ALL;

  Icon CRT_ICO_DISM() => _DISMISSING;
}