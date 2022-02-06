import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/core/routes/core_routes.dart';

import '../../../../../core/components/snackbar/core_button_snackbar.dart';
import '../../../../../core/components/snackbar/core_snackbar.dart';
import '../../../../../core/properties/propertiesdart';
import '../../../../../core/texts/core_messages.dart';
import '../../../../cart/controller/cart_controller.dart';
import '../../../../inventory/entity/product.dart';
import '../../../controller/overview_controller.dart';
import '../../../service/i_overview_service.dart';
import '../../overview_icons.dart';
import '../../overview_keys.dart';
import 'icustom_grid_item.dart';

class SimpleGridItem extends StatelessWidget implements ICustomGridtile {
  final Product _product;
  final _icons = Get.find<OverviewIcons>();
  final _cartController = Get.find<CartController>();
  final _uniqueController = OverviewController(service: Get.find<IOverviewService>());
  final String index;
  final _messages = Get.find<CoreMessages>();
  final _words = Get.find<CoreLabels>();
  final _keys = Get.find<OverviewKeys>();

  SimpleGridItem(this._product, this.index);

  @override
  Widget build(BuildContext context) {
    _uniqueController.favoriteStatusObs.value = _product.isFavorite;
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(220, 220, 220, 10)),
            borderRadius: BorderRadius.circular(10.0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: customGridTile(context, _product, index, _uniqueController),
        ));
  }

  @override
  Widget customGridTile(
    context,
    Product product,
    String index,
    OverviewController uniqueController,
  ) {
    var fadeImage = FadeInImage(
      placeholder: AssetImage(IMAGE_PLACEHOLDER),
      image: NetworkImage(product.imageUrl),
      fit: BoxFit.cover,
    );

    return GridTile(
        child: GestureDetector(
            key: Key("${_keys.k_ov_itm_det_page}$index"),
            onTap: () => Get.toNamed('${CoreRoutes.OVERVIEW_ITEM_DETAILS}${product.id}'),
            child: fadeImage),
        footer: GridTileBar(
            leading: Obx(
              () => _favButton(index, product, context),
            ),
            title: Text(product.title, key: Key("${_keys.k_ov_grd_prd_tit}$index")),
            trailing: _shopCartButton(index, product, context),
            backgroundColor: Colors.black87));
  }

  IconButton _shopCartButton(String index, Product product, context) {
    return IconButton(
        key: Key("${_keys.k_ov_grd_crt_btn}$index"),
        icon: _icons.ico_shopcart(),
        onPressed: () {
          _cartController.addCartItem(product);
          CoreButtonSnackbar(
            context: context,
            labelButton: _words.undo(),
            function: () => _cartController.addCartItemUndo(product),
          ).show(
            _words.done(),
            "${product.title}${_messages.item_cart_added}",
          );
        },
        color: Theme.of(context).colorScheme.secondary);
  }

  IconButton _favButton(String index, Product product, context) {
    return IconButton(
        key: Key("${_keys.k_ov_grd_fav_btn}$index"),
        icon: _uniqueController.favoriteStatusObs.value
            ? _icons.ico_fav()
            : _icons.ico_nofav(),
        onPressed: () {
          _uniqueController.toggleFavoriteStatus(product.id!).then((response) {
            response
                ? CoreSnackbar().show(_words.suces, _messages.tog_status_suces)
                : CoreSnackbar().show(_words.ops, _messages.tog_status_error);
          });
        },
        color: Theme.of(context).colorScheme.secondary);
  }
}