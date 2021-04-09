import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopingapp/app/core/properties/app_properties.dart';

import 'core/keys/custom_circ_progr_indicator_keys.dart';

// ignore: must_be_immutable
class CustomProgressIndicator extends StatefulWidget {
  double radius;
  String message = '';
  double fontSize;
  bool _showCircularProgressIndicator = true;

  CustomProgressIndicator.radius([this.radius]);

  CustomProgressIndicator.message({this.message, this.fontSize});

  CustomProgressIndicator();

  @override
  _CustomProgressIndicatorState createState() => _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  @override
  void initState() {
    super.initState();
    if (widget.message.isNotEmpty) _timer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _timer() async {
    await Future.delayed(Duration(seconds: CUST_PROG_INDIC_TIMER_TEXT));

    if (mounted) {
      setState(() {
        widget._showCircularProgressIndicator = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(K_CIRC_PRG_INDIC),
      width: widget.radius ?? MediaQuery.of(context).size.width,
      height: widget.radius ?? MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: widget._showCircularProgressIndicator
          ? CircularProgressIndicator()
          : Text(widget.message, style: TextStyle(fontSize: widget.fontSize)),
    );
  }
}
