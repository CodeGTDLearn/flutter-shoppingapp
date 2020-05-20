import 'dart:ui';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../config/titlesIconsMessages/views/itemOverviewView.dart';

class FlushNotifier {
  final String _title;
  final String _message;
  final int _duration;
  final BuildContext _context;

  FlushNotifier(this._title, this._message, this._duration, this._context);

  Future<Object> simple() {
    return Flushbar(
      title: _title,
      message: _message,
      duration: Duration(milliseconds: _duration),
      icon: IOV_ICO_FAV_NOTIF,
    ).show(_context);
  }

  Future<Object> withButton(String labelButton, Function function) {
    return Flushbar(
      title: _title,
      message: _message,
      duration: Duration(milliseconds: _duration),
      icon: IOV_ICO_FAV_NOTIF,
      mainButton: FlatButton(
        onPressed: function,
        child: Text(
          labelButton,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(_context).accentColor,
          ),
        ),
      ),
    ).show(_context);
  }
}
