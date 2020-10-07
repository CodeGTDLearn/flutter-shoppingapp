import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/i_overview_controller.dart';

import '../../../core/properties/app_properties.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../cart/controller/cart_controller.dart';
import '../../managed_products/entities/product.dart';
import '../../pages_generic_components/custom_flush_notifier.dart';
import '../controller/overview_controller.dart';
import '../core/messages_snackbars_provided.dart';
import '../core/overview_texts_icons_provided.dart';

class OverviewGridItem extends StatelessWidget {
  // final OverviewController _controller = OverviewController();
  final Product _product;

  OverviewGridItem(this._product);


  final OverviewController _controller =
  OverviewController(service: Get.find());


  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    _controller.favoriteStatusObs.value = _product.isFavorite;
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(220, 220, 220, 10)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: GridTile(
                child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.OVERVIEW_DETAIL,
                        arguments: _product.id),
                    child: Image.network(_product.imageUrl, fit: BoxFit.cover)),
                footer: GridTileBar(
                    leading: Obx(
                      () => IconButton(
                          icon: _controller.favoriteStatusObs.value
                              ? OVERV_ICO_FAV
                              : OVERV_ICO_NOFAV,
                          onPressed: () =>
                              _controller.toggleFavoriteStatus(_product.id),
                          color: Theme.of(context).accentColor),
                    ),
                    title: Text(_product.title),
                    trailing: IconButton(
                        icon: OVERV_ICO_SHOP,
                        onPressed: () {
                          _cartController.addProductInTheCart(_product);
                          FlushNotifier(
                                  DONE,
                                  "${_product.title}$ITEMCART_ADDED",
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

  // @formatter:off
  // final OverviewController _controller =
  // Get.put(OverviewController(service: Get.find()));
  // OverviewController(
  //     OverviewService(
  //         OverviewFirebaseRepo()));

  // OverviewController(
  //     Get.put(OverviewService(
  //         Get.put(OverviewFirebaseRepo()))));
  // @formatter:on
