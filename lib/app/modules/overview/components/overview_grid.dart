import 'package:flutter/material.dart';

import '../../../config/app_monitor_builds.dart';
import '../../../config/messages/grid_products.dart';
import '../product.dart';
import 'overview_item/overview_item.dart';

class OverviewGrid extends StatelessWidget {
  List<Product> filteredProducts;

  OverviewGrid(this.filteredProducts);

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_COMP_GRIDPRODUCTS);
    return filteredProducts.length == 0
        ? Center(child: Text(GRID_PRODUCTS_MSG, style: TextStyle(fontSize: 20)))
        : GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: filteredProducts.length,
            itemBuilder: (ctx, item) => OverviewItem(filteredProducts[item]),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
          );
  }
}
