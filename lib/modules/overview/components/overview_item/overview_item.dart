import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app_routes.dart';
import '../../../../core/components/flush_notifier.dart';
import '../../../../core/configurable/app_properties.dart';
import '../../../../core/configurable/textual_interaction/messages/flush_notifier.dart';
import '../../../../core/configurable/textual_interaction/titles_icons/app_core.dart';
import '../../../../core/configurable/textual_interaction/titles_icons/views/overview.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../managed_products/entities/product.dart';
import 'overview_item_controller.dart';

class OverviewItem extends StatelessWidget {
  final Product _product;

  OverviewItem(this._product);

  final OverviewItemController _itemControl = OverviewItemController();

  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    _itemControl.favoriteStatus.value = _product.isFavorite;
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(220, 220, 220, 10)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: GridTile(
                child: GestureDetector(
                    onTap: () => Get.toNamed(
                        '$AppRoutes.OVERVIEW_DETAIL_ROUTE${_product.id}'),
                    child: Image.network(_product.imageUrl, fit: BoxFit.cover)),
                footer: GridTileBar(
                    leading: Obx(
                      () => IconButton(
                          icon: _itemControl.favoriteStatus.value
                              ? OVERVIEW_ICO_FAV
                              : OVERVIEW_ICO_NOFAV,
                          onPressed: () =>
                              _itemControl.toggleFavorite(_product.id),
                          color: Theme.of(context).accentColor),
                    ),
                    title: Text(_product.title),
                    trailing: IconButton(
                        icon: OVERVIEW_ICO_SHOP,
                        onPressed: () {
                          _cartController.addProductInTheCart(_product);
                          FlushNotifier(
                                  DONE,
                                  _product.title + MSG_ITEMCART_ADDED,
                                  INTERVAL,
                                  context)
                              .withButton(UNDO, () {
                            _cartController.undoAddProductInTheCart(_product);
                          });
                        },
                        color: Theme.of(context).accentColor),
                    backgroundColor: Colors.black87))));
  }
}
