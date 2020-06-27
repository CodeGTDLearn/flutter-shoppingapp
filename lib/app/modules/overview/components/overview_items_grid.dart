import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../config/app_monitor_builds.dart';
import '../../../config/messages/grid_products.dart';
import '../controllers/overview_controller.dart';
import '../product.dart';
import 'overview_item.dart';

class OverviewItemsGrid extends StatefulWidget {
  final List<Product> _products;

  OverviewItemsGrid(this._products);

  @override
  _OverviewItemsGridState createState() => _OverviewItemsGridState();
}

class _OverviewItemsGridState
    extends ModularState<OverviewItemsGrid, OverviewController> {
  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_COMP_GRIDPRODUCTS);
    return controller.qtdeProducts() == 0
        ? Center(child: Text(GRID_PRODUCTS_MSG, style: TextStyle(fontSize: 20)))
        : GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: widget._products.length,
            itemBuilder: (ctx, item) => OverviewItem(widget._products[item]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          );
  }
}
