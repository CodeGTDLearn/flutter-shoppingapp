import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final String message;

  CustomCircularProgressIndicator([this.message]);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, cons) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                message == null
                    ? CircularProgressIndicator()
                    : Center(
                        child: Text(message,
                            style: TextStyle(fontSize: cons.maxWidth * 0.07))),
                SizedBox(height: cons.maxWidth * 0.05),
                Center(child: CircularProgressIndicator()),
              ]));
    });
  }
}
