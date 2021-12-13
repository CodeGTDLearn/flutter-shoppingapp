import 'package:flutter/material.dart';

import '../../../../modules/inventory/entity/product.dart';
import '../custom_listtile/simple_listtile.dart';
import 'icustom_inventory_listview.dart';

class SimpleListview implements ICustomInventoryListview {
  @override
  Widget customInventoryListview(List<Product> productsList) {
    return ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (ctx, index) => Column(children: [
              SimpleListTile().customListTile(productsList.elementAt(index)),
              Divider()
            ]));
  }
}