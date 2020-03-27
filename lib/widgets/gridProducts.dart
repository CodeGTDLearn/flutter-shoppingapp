import 'package:flutter/material.dart';

import '../widgets/gridProductItem.dart';
import '../entities_models/product.dart';

class GridProducts extends StatelessWidget {
  List<Product> _products;

  GridProducts(this._products);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: _products.length,
      itemBuilder: (ctx, item) {
        return GridProductItem(_products[item]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
