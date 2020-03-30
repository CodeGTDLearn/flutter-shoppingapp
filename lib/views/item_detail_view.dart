import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:shopingapp/service_stores/ItemsOverviewGridProductItemStore.dart';

class ItemDetailView extends StatelessWidget {
  final String _id;
  var _servStore = Modular.get<IItemsOverviewGridProductItemStore>();

  ItemDetailView(this._id);

  //could be done with Statefull widget as well
  @override
  Widget build(BuildContext context) {
    var _item = _servStore.getById(_id);
    return Scaffold(
        appBar: AppBar(title: Text(_item.title)),
        body: SingleChildScrollView(
            child: Column(
          children: [
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
                    textAlign: TextAlign.center, style: Theme.of(context).textTheme.body1))
          ]
        )));
  }
}
