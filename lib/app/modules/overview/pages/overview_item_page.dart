import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../config/app_monitor_builds.dart';
import '../controllers/overview_item_controller.dart';

class OverviewItemPage extends StatefulWidget {
  final String _id;

  OverviewItemPage(this._id);

  @override
  _OverviewItemPageState createState() => _OverviewItemPageState();
}

class _OverviewItemPageState
    extends ModularState<OverviewItemPage, OverviewItemController> {
//  final _store = Modular.get<OverviewItemController>();

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_COMP_ITEMDETAIL);
    var _item = controller.getById(widget._id);
    return Scaffold(
        appBar: AppBar(title: Text(_item.get_title())),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              height: 300,
              width: double.infinity,
              child: Image.network(_item.get_imageUrl(), fit: BoxFit.cover)),
          SizedBox(height: 10),
          Text('\$${_item.get_price()}'),
          SizedBox(height: 10),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(_item.get_description(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1))
        ])));
  }
}
