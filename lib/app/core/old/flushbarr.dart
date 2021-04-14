import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../modules/components/core/texts_icons/custom_flush_notifier_texts_icons_provided.dart';
import '../properties/app_properties.dart';
import 'flushbar_keys.dart';

class Flushbarr {
  final String _title;
  final String _message;
  final int _duration;
  final BuildContext _context;

  Flushbarr(this._title, this._message, this._context, [this._duration]);

  Future<Object> simple() {
    return Flushbar(
            key: Key(K_FB01),
            title: _title,
            message: _message,
            duration: Duration(milliseconds: _duration ?? DURATION),
            icon: FLUSHNOT_ICO)
        .show(_context);
  }

  Future<Object> withButton(String labelButton, Function function) {
    return Flushbar(
            key: Key(K_FB01),
            title: _title,
            message: _message,
            duration: Duration(milliseconds: _duration),
            icon: FLUSHNOT_ICO,
            mainButton: FlatButton(
                key: Key(K_FB02),
                onPressed: function,
                child: Text(labelButton,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(_context).accentColor))))
        .show(_context);
  }
}
