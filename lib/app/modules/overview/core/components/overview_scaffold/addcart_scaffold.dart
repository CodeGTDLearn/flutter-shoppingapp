import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../../core/components/core_adaptive_indicator.dart';
import '../../../../../core/components/snackbar/core_snackbar.dart';
import '../../../../../core/routes/core_routes.dart';
import '../../../../../core/texts/core_labels.dart';
import '../../../../../core/texts/core_messages.dart';
import '../../../../cart/controller/cart_controller.dart';
import '../../overview_icons.dart';
import '../../overview_keys.dart';
import '../custom_grid_item/animated_grid_item.dart';
import 'ioverview_scaffold.dart';

class AddCartScaffold implements IOverviewScaffold {
  final _icons = Get.find<OverviewIcons>();
  final _cartController = Get.find<CartController>();
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  final _messages = Get.find<CoreMessages>();
  final _words = Get.find<CoreLabels>();
  final _keys = Get.find<OverviewKeys>();

  Widget overviewScaffold(_drawer, _controller, _appbar) {
    _appbar.cart = GestureDetector(
      onTap: () {
        _cartController.getAllCartItems().isEmpty
            ? CoreSnackbar().show(_words.ops, _messages.cart_no_items_yet)
            : Get.toNamed(CoreRoutes.CART);
      },
      child: AddToCartIcon(key: gkCart, icon: _icons.ico_shopcart()),
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
          runAddToCardAnimation = addToCardAnimationMethod;
        },
        child: Scaffold(
          key: _keys.k_ov_scfld_glob_key(),
          appBar: _appbar,
          drawer: _drawer,
          body: Obx(() => (_controller.gridItemsObs.value.isEmpty
              ? SingleChildScrollView(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                      CoreAdaptiveIndicator.message(
                          message: _messages.no_products_yet, fontSize: 20)
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