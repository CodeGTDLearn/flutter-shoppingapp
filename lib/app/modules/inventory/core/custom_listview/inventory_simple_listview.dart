import 'package:flutter/material.dart';

import '../../../../modules/inventory/entity/product.dart';
import '../custom_listtile/simple_listtile.dart';
import 'icustom_inventory_listview.dart';

class InventorySimpleListview implements ICustomInventoryListview {
  @override
  Widget create(List<Product> productsList) {
    return ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (ctx, index) => Column(children: [
              SimpleListTile().create(productsList.elementAt(index)),
              Divider()
            ]));
  }
}