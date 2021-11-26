import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/custom_widgets/custom_snackbar/button_snackbar.dart';
import '../../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../../core/keys/overview_keys.dart';
import '../../../../core/properties/app_routes.dart';
import '../../../../core/texts_icons_provider/generic_words.dart';
import '../../../../core/texts_icons_provider/pages/overview/messages_snackbars_provided.dart';
import '../../../../core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../inventory/entity/product.dart';
import '../../controller/overview_controller.dart';
import 'icustom_gridtile.dart';

class SimpleGridtile implements ICustomGridtile {
  final _cartController = Get.find<CartController>();

  @override
  Widget create(
    final context,
    final Product product,
    final String index,
    final OverviewController _uniqueController,
  ) {
    return GridTile(
        child: GestureDetector(
            key: Key("$K_OV_ITM_DET_PAGE$index"),
            onTap: () => Get.toNamed('${AppRoutes.OVERVIEW_DETAIL}${product.id}'),
            child: Image.network(product.imageUrl, fit: BoxFit.cover)),
        footer: GridTileBar(
            leading: Obx(
              () => IconButton(
                  key: Key("$K_OV_GRD_FAV_BTN$index"),
                  icon: _uniqueController.favoriteStatusObs.value
                      ? OV_ICO_FAV
                      : OV_ICO_NOFAV,
                  onPressed: () {
                    _uniqueController.toggleFavoriteStatus(product.id!).then((response) {
                      response
                          ? SimpleSnackbar(SUCES, TOG_STATUS_SUCES).show()
                          : SimpleSnackbar(OPS, TOG_STATUS_ERROR).show();
                    });
                  },
                  color: Theme.of(context).colorScheme.secondary),
            ),
            title: Text(product.title, key: Key("$K_OV_GRD_PRD_TIT$index")),
            trailing: IconButton(
                key: Key("$K_OV_GRD_CRT_BTN$index"),
                icon: OV_ICO_SHOPCART,
                onPressed: () {
                  _cartController.addCartItem(product);
                  ButtonSnackbar(
                    context: context,
                    title: DONE,
                    message: "${product.title}$ITEMCART_ADDED",
                    labelButton: UNDO,
                    function: () => _cartController.addCartItemUndo(product),
                  ).show();
                },
                color: Theme.of(context).colorScheme.secondary),
            backgroundColor: Colors.black87));
  }
}