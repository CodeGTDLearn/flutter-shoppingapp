import 'package:flutter/material.dart';

class CustomCircProgresIndicator extends StatelessWidget {
  final String message;

  CustomCircProgresIndicator({this.message});

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
                //todo: id not message show only the circular progress indicator
                Center(
                    child: Text(message,
                        style: TextStyle(fontSize: cons.maxWidth * 0.07))),
                SizedBox(height: cons.maxWidth * 0.05),
                Center(child: CircularProgressIndicator()),
              ]));
    });
  }
}
