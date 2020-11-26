import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  double radius;

  CustomCircularProgressIndicator.radius([this.radius]);
  CustomCircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius ?? MediaQuery.of(context).size.width,
      height: radius ?? MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }
}
    // var _width =
    //     radius == null ? MediaQuery.of(context).size.width :
    //     CIRC_PROG_IND_RAD;
    // var _height =
    //     radius == null ? MediaQuery.of(context).size.height : CIRC_PROG_IND_RAD;
