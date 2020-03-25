import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/entities_models/product.dart';
import 'package:shopingapp/service_stores/grid_products_serv_store.dart';

import 'ProductItemGrid.dart';

class GridProducts extends StatelessWidget {
  int _FavoritesFilter;
  final _serv_store = Modular.get<GridProductServStore>();

  GridProducts(this._FavoritesFilter);

  @override
  Widget build(BuildContext context) {
    List<Product> products =
        _serv_store.gridViewProducts(_FavoritesFilter);

    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, item) {
        return ProductItemGrid(products[item]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
