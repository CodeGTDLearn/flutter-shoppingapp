import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/app_properties.dart';
import '../../../../config/app_routes.dart';
import '../../../../config/messages/flush_notifier.dart';
import '../../../../config/titles_icons/app_core.dart';
import '../../../../config/titles_icons/views/overview.dart';
import '../../../cart/cart_controller.dart';
import '../../../core/components/flush_notifier.dart';
import '../../product.dart';
import 'overview_item_controller.dart';

class OverviewItem extends StatelessWidget {
  final Product _product;

  OverviewItem(this._product);

  final OverviewItemController _ovControl = Get.put(OverviewItemController());
  final CartController _cartControl = Get.find();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: GridTile(
            child: GestureDetector(
//                onTap: () => Get.toNamed(OVERVIEW_DETAIL_ROUTE + _product.id),
                onTap: () =>
                    Get.toNamed('$OVERVIEW_DETAIL_ROUTE${_product.id}'),
                child:
                    Image.network(_product.imageUrl, fit: BoxFit.cover)),
            footer: GridTileBar(
                leading: IconButton(
                    icon: _ovControl.favoriteStatus ?? _product.isFavorite
                        ? OVERVIEW_ICO_FAV
                        : OVERVIEW_ICO_NOFAV,
                    onPressed: () =>
                        _ovControl.toggleFavorite(_product.id),
                    color: Theme.of(context).accentColor),
                title: Text(_product.title),
                trailing: IconButton(
                    icon: OVERVIEW_ICO_SHOP,
                    onPressed: () {
                      _cartControl.addProductInTheCart(_product);
                      FlushNotifier(
                              DONE,
                              _product.title + FLUSHNOTIF_MSG_CART_ADD,
                              INTERVAL,
                              context)
                          .withButton(UNDO, () {
                        _cartControl.undoAddProductInTheCart(_product);
                      });
                    },
                    color: Theme.of(context).accentColor),
                backgroundColor: Colors.black87)));
  }
}
