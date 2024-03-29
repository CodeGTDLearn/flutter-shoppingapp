import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../properties/properties.dart';
import 'core_components_keys.dart';

// ignore: must_be_immutable
class CoreAdaptiveIndicator extends StatefulWidget {
  double? radius;
  String? message;
  double? fontSize;
  bool _showCircularProgressIndicator = true;
  final _keys = Get.find<CoreComponentsKeys>();

  CoreAdaptiveIndicator.message({required this.message, required this.fontSize});

  CoreAdaptiveIndicator.radius([this.radius]);

  CoreAdaptiveIndicator();

  @override
  _CoreAdaptiveIndicatorState createState() => _CoreAdaptiveIndicatorState();
}

class _CoreAdaptiveIndicatorState extends State<CoreAdaptiveIndicator> {
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
          ? CircularProgressIndicator.adaptive()
          : Text(widget.message!, style: TextStyle(fontSize: widget.fontSize)),
    );
  }
}