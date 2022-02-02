import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../../../../core/components/snackbar/button_snackbar.dart';
import '../../../../../core/components/snackbar/simple_snackbar.dart';
import '../../../../../core/properties/properties.dart';
import '../../../../../core/texts/global_labels.dart';
import '../../../../../core/texts/global_messages.dart';
import '../../../../../core/utils/animations_utils.dart';
import '../../../../cart/controller/cart_controller.dart';
import '../../../../inventory/entity/product.dart';
import '../../../controller/overview_controller.dart';
import '../../../service/i_overview_service.dart';
import '../../../view/overview_item_details_view.dart';
import '../../overview_icons.dart';
import '../../overview_keys.dart';
import 'icustom_grid_item.dart';

class AnimatedGridItem extends StatelessWidget implements ICustomGridtile {
  final Product _product;

  final _icons = Get.find<OverviewIcons>();
  final _cartController = Get.find<CartController>();
  final _animations = Get.find<AnimationsUtils>();
  final _uniqueController = OverviewController(service: Get.find<IOverviewService>());
  final String index;
  final void Function(GlobalKey)? onClick;
  final GlobalKey imageGlobalKey = GlobalKey();
  final _messages = Get.find<GlobalMessages>();
  final _words = Get.find<GlobalLabels>();
  final _keys = Get.find<OverviewKeys>();

  AnimatedGridItem(this._product, this.index, {this.onClick});

  @override
  Widget build(BuildContext context) {
    _uniqueController.favoriteStatusObs.value = _product.isFavorite;

    return Obx(
      () => AnimatedPhysicalModel(
          duration: const Duration(milliseconds: 350),
          curve: Curves.fastOutSlowIn,
          elevation: _uniqueController.gridItemElevateAnimationObs.value ? 0 : 30.0,
          shape: BoxShape.rectangle,
          shadowColor: Colors.black,
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          onEnd: () => _uniqueController.elevateGridItemAnimation(true),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(220, 220, 220, 10)),
                  borderRadius: BorderRadius.circular(10.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: customGridTile(context, _product, index, _uniqueController),
              ))),
    );
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
        fit: BoxFit.cover);

    return _animations.openContainer(
      openingWidget: OverviewItemDetailsView(product.id),
      closingWidget: GridTile(
          key: Key("${_keys.k_ov_itm_det_page()}$index"),
          child: Container(
              key: imageGlobalKey,
              child:
                  ClipRRect(borderRadius: BorderRadius.circular(10.0), child: fadeImage)),
          footer: GridTileBar(
              leading:
                  Obx(() => _favoriteButton(index, context, uniqueController, product)),
              title: Text(product.title, key: Key("${_keys.k_ov_grd_prd_tit()}$index")),
              trailing: _shopCartButton(index, uniqueController, product, context),
              backgroundColor: Colors.black87)),
    );
  }

  IconButton _favoriteButton(
      String index, context, OverviewController uniqueController, Product product) {
    return IconButton(
        key: Key("${_keys.k_ov_grd_fav_btn}$index"),
        color: Theme.of(context).colorScheme.secondary,
        icon: uniqueController.favoriteStatusObs.value
            ? _icons.ico_fav()
            : _icons.ico_nofav(),
        onPressed: () {
          uniqueController.toggleFavoriteStatus(product.id!).then((response) {
            response
                ? SimpleSnackbar().show(_words.suces, _messages.tog_status_suces)
                : SimpleSnackbar().show(_words.ops, _messages.tog_status_error);
          });
        });
  }

  IconButton _shopCartButton(
      String index, OverviewController uniqueController, Product product, context) {
    return IconButton(
        key: Key("${_keys.k_ov_grd_crt_btn}$index"),
        icon: _icons.ico_shopcart(),
        onPressed: () {
          uniqueController.elevateGridItemAnimation(false);
          _cartController.addCartItem(product);
          ButtonSnackbar(
            context: context,
            labelButton: _words.undo(),
            function: () => _cartController.addCartItemUndo(product),
          ).show(_words.done, "${product.title}${_messages.item_cart_added}");
        },
        color: Theme.of(context).colorScheme.secondary);
  }
}