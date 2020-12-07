import 'package:flutter/material.dart';

// ignore: must_be_immutable
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