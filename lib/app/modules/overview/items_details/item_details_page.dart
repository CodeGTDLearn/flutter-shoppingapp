import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_monitor_builds.dart';

import '../overview_grid_product_item_controller.dart';

class ItemDetailsPage extends StatelessWidget {
  final String _id;
  final _store = Modular.get<OverviewGridProductItemController>();

  ItemDetailsPage(this._id);

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_COMP_ITEMDETAIL);
    var _item = _store.getById(_id);
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
