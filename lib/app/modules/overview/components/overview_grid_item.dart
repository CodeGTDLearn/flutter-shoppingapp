import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/snackbarr.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../cart/controller/cart_controller.dart';
import '../../inventory/entities/product.dart';
import '../controller/overview_controller.dart';
import '../core/messages_snackbars_provided.dart';
import '../core/overview_texts_icons_provided.dart';
import '../core/overview_widget_keys.dart';

class OverviewGridItem extends StatelessWidget {
  final Product _product;
  final OverviewController _controller = OverviewController(service: Get.find());
  final CartController _cartController = Get.find();
  final String index;

  OverviewGridItem(this._product, this.index);

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
                    key: Key("$K_OV_ITM_DET_PAGE$index"),
                    onTap: () => Get.toNamed(AppRoutes.OVERVIEW_DETAIL,
                        arguments: _product.id),
                    child: Image.network(_product.imageUrl, fit: BoxFit.cover)),
                footer: GridTileBar(
                    leading: Obx(
                      () => IconButton(
                          key: Key("$K_OV_GRD_FAV_BTN$index"),
                          icon: _controller.favoriteStatusObs.value
                              ? OV_ICO_FAV
                              : OV_ICO_NOFAV,
                          onPressed: () {
                            _controller
                                .toggleFavoriteStatus(_product.id)
                                .then((returnedFavStatus) {
                              if (returnedFavStatus) {
                                SimpleSnackbar(SUCES, TOGGL_STATUS_SUCES).show();
                              } else {
                                SimpleSnackbar(OPS, TOGGL_STATUS_ERROR).show();
                              }
                            });
                          },
                          color: Theme.of(context).accentColor),
                    ),
                    title: Text(_product.title, key: Key("$K_OV_GRD_PRD_TIT$index")),
                    trailing: IconButton(
                        key: Key("$K_OV_GRD_CRT_BTN$index"),
                        icon: OV_ICO_SHOPCART,
                        onPressed: () {
                          _cartController.addCartItem(_product);
                          ButtonSnackbar(
                            context: context,
                            title: DONE,
                            message: "${_product.title}$ITEMCART_ADDED",
                            labelButton: UNDO,
                            function: () =>
                                _cartController.addCartItemUndo(_product),
                          ).show();
                        },
                        color: Theme.of(context).accentColor),
                    backgroundColor: Colors.black87))));
  }
}

// Get.snackbar(
//   SUCESS,
//   TOGGLE_STATUS_SUCESS,
//   duration: Duration(milliseconds: 1000),
//   snackPosition: SnackPosition.TOP,
//   backgroundColor: Colors.black,
//   colorText: Colors.white,
// );
