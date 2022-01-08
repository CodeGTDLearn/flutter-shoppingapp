import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../keys/global_widgets_keys.dart';
import '../properties/properties.dart';

// ignore: must_be_immutable
class CustomIndicator extends StatefulWidget {
  double? radius;
  String? message;
  double? fontSize;
  bool _showCircularProgressIndicator = true;
  final _keys = Get.find<GlobalWidgetsKeys>();

  CustomIndicator.message({required this.message, required this.fontSize});

  CustomIndicator.radius([this.radius]);

  CustomIndicator();

  @override
  _CustomIndicatorState createState() => _CustomIndicatorState();
}

class _CustomIndicatorState extends State<CustomIndicator> {
  @override
  void initState() {
    super.initState();
    if (widget.message != null) _timer();
  }

  @override
  void dispose() => super.dispose();

  void _timer() async {
    await Future.delayed(Duration(seconds: CUST_PROG_INDIC_TIMER_TEXT));

    if (mounted) {
      setState(() => widget._showCircularProgressIndicator = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(widget._keys.k_circ_prg_indic()),
      width: widget.radius ?? MediaQuery.of(context).size.width,
      height: widget.radius ?? MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: widget._showCircularProgressIndicator
          ? CircularProgressIndicator()
          : Text(widget.message!, style: TextStyle(fontSize: widget.fontSize)),
    );
  }
}