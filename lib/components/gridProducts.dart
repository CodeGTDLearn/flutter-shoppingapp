import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../components/gridProductItem.dart';
import '../config/titlesIconsMessages/widgets/gridProducts.dart';
import '../entities/product.dart';
import '../services/itemsOverviewGridProductsStore.dart';

class GridProducts extends StatelessWidget {
  List<Product> _products;
  var _store = Modular.get<ItemsOverviewGridProductsStoreInt>();

  GridProducts(this._products);

  @override
  Widget build(BuildContext context) {
    return _store.qtdeItems() == 0
        ? Center(child: Text(GRD_PRODUCT_MSG, style: TextStyle(fontSize: 20)))
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
