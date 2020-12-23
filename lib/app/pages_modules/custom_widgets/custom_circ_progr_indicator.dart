import 'package:flutter/material.dart';

import 'core/keys/custom_circ_progr_indicator_keys.dart';

// ignore: must_be_immutable
class CustomCircProgrIndicator extends StatelessWidget {
  double radius;

  CustomCircProgrIndicator.radius([this.radius]);

  CustomCircProgrIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(K_CIRC_PRG_INDIC),
      width: radius ?? MediaQuery.of(context).size.width,
      height: radius ?? MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
