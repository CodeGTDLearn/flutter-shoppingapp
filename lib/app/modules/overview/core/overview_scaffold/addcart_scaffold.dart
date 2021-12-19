import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/custom_widgets/custom_indicator.dart';
import '../../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../../core/keys/overview_keys.dart';
import '../../../../core/properties/app_routes.dart';
import '../../../../core/texts_icons_provider/generic_words.dart';
import '../../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../../../../core/texts_icons_provider/pages/overview/messages_snackbars_provided.dart';
import '../../../../core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';
import '../../../cart/controller/cart_controller.dart';
import '../custom_grid_item/animated_grid_item.dart';
import 'icustom_scaffold.dart';

class AddCartScaffold implements ICustomScaffold {
  final _cartController = Get.find<CartController>();
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;

  Widget customScaffold(_drawer, _controller, _appbar) {
    _appbar.cart = GestureDetector(
      onTap: () {
        _cartController.getAllCartItems().isEmpty
            ? SimpleSnackbar().show(OPS, CART_NO_ITEMS_YET)
            : Get.toNamed(AppRoutes.CART);
      },
      child: AddToCartIcon(key: gkCart, icon: OV_ICO_SHOPCART),
    );

    return AddToCartAnimation(
        gkCart: gkCart,
        rotation: false,
        dragToCardCurve: Curves.easeIn,
        dragToCardDuration: const Duration(milliseconds: 1000),
        previewCurve: Curves.linearToEaseOut,
        previewDuration: const Duration(milliseconds: 500),
        previewHeight: 30,
        previewWidth: 30,
        opacity: 0.85,
        initiaJump: false,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          this.runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Scaffold(
          key: K_OV_SCFLD_GLOB_KEY,
          appBar: _appbar,
          drawer: _drawer,
          body: Obx(() => (_controller.gridItemsObs.value.isEmpty
              ? SingleChildScrollView(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                      CustomIndicator.message(message: NO_PROD, fontSize: 20)
                    ])))
              : AnimationLimiter(
                  child: GridView.count(
                      crossAxisCount: 2,
                      children:
                          List.generate(_controller.gridItemsObs.value.length, (index) {
                        return AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: 2,
                            child: ScaleAnimation(
                                duration: Duration(milliseconds: 2000),
                                child: FadeInAnimation(
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AnimatedGridItem(
                                          _controller.gridItemsObs.value.elementAt(index),
                                          index.toString(),
                                          onClick: listClick,
                                        )))));
                      }))))),
        ));
  }

  void listClick(GlobalKey gkImageContainer) async {
    await runAddToCardAnimation(gkImageContainer);
    await gkCart.currentState!.runCartAnimation(
      _cartController.qtdeCartItemsObs.value.toString(),
    );
  }
}