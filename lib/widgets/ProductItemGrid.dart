import 'package:flutter/material.dart';
import 'package:shopingapp/entities_models/product.dart';

import 'package:shopingapp/config/titlesIcons.dart';

class ProductItemGrid extends StatelessWidget {
  Product _product;

  ProductItemGrid(this._product);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: GridTile(
        child: GestureDetector(
          onTap: null,
          child: Image.network(
            _product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: IOS_ICO_FAV,
            onPressed: null,
            color: Theme.of(context).accentColor,
          ),
          title: Text(this._product.title),
          trailing: IconButton(
            icon: IOS_ICO_SHOP,
            onPressed: null,
            color: Theme.of(context).accentColor,
          ),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
