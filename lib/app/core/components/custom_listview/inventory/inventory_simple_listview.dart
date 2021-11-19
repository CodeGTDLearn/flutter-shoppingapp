import 'package:flutter/material.dart';

import '../../../../modules/inventory/components/inventory_item.dart';
import '../../../../modules/inventory/entity/product.dart';
import 'icustom_inventory_listview.dart';

class InventorySimpleListview implements ICustomInventoryListview {
  @override
  Widget create(List<Product> productsList) {
    return ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (ctx, index) => Column(children: [
              InventoryItem(product: productsList.elementAt(index)),
              Divider(),
            ]));
  }
}