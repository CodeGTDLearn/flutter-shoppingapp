import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/overview_controller.dart';


class OverviewItemDetailsPage extends StatelessWidget {
  final String _id = Get.arguments;
  // final OverviewController _controller = Get.find();
  final OverviewController controller;

  OverviewItemDetailsPage({this.controller});

  @override
  Widget build(BuildContext context) {
    var _item = controller.getProductById(_id);
    return Scaffold(
        appBar: AppBar(title: Text(_item.title)),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              height: 300,
              width: double.infinity,
              child: Image.network(_item.imageUrl, fit: BoxFit.cover)),
          SizedBox(height: 10),
          Text('\$${_item.price}'),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(_item.description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1))
        ])));
  }
}
