import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_monitor_builds.dart';
import 'package:shopingapp/app/config/messages/grid_products.dart';

import '../overview_grid_product_controller.dart';
import '../product.dart';
import 'grid_product_item.dart';

class GridProducts extends StatelessWidget {
  final List<Product> _products;
  final _store = Modular.get<OverviewGridProductControllerBase>();

  GridProducts(this._products);

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_COMP_GRIDPRODUCTS);
    return _store.qtdeItems() == 0
        ? Center(child: Text(GRID_PRODUCTS_MSG, style: TextStyle(fontSize: 20)))
        : GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: _products.length,
            itemBuilder: (ctx, item) => GridProductItem(_products[item]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          );
  }
}
