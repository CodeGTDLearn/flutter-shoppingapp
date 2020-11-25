import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  String message;
  double radius;

  CustomCircularProgressIndicator([this.message]);
  CustomCircularProgressIndicator.radius([this.radius]);
  // CustomCircularProgressIndicator.full([this.message, this.radius]);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constr) {
      // var cHeight = constr.maxHeight;

      var cWidth = constr.maxWidth;
      var _circleDiameter = radius == null ? constr.maxWidth * 0.1 : radius * 2;
      constr.maxWidth * 0.1;
      var _message = message ?? "";

      return Container(
          width: MediaQuery.of(context).size.width,
          // width: _circleDiameter,
          height: MediaQuery.of(context).size.height,
          // height: _circleDiameter,
          child: _message.isEmpty
              ? Container(
                  child: CircularProgressIndicator(),
                  width: _circleDiameter,
                  height: _circleDiameter)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Text(message, style: TextStyle(fontSize: cWidth * 0.07)),
                      SizedBox(height: cWidth * 0.05),
                      Container(
                          child: CircularProgressIndicator(),
                          width: _circleDiameter,
                          height: _circleDiameter)
                    ]));
    });
  }
}
