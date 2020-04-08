import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shopingapp/config/titlesIcons.dart';

class FlushNotifier {
  final String _title;
  final String _message;
  final int _duration;
  final BuildContext _context;

  FlushNotifier(this._title, this._message, this._duration, this._context);

  Future<Object> show() {
    return Flushbar(
      title: _title,
      message: _message,
      duration: Duration(milliseconds: _duration),
      icon: IOS_ICO_FAV_NOTIF,
    ).show(_context);
  }
}
