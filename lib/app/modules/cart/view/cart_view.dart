import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/components/appbar/core_appbar.dart';
import '../../../core/properties/properties.dart';
import '../controller/cart_controller.dart';
import '../core/cart_labels.dart';
import '../core/components/cartview_header.dart';
import '../core/components/clear_cart_button.dart';
import '../core/components/custom_listview/cart_staggered_listview.dart';

class CartView extends StatelessWidget {
  final _controller = Get.find<CartController>();
  final _appbar = Get.find<CoreAppBar>();
  final _labels = Get.find<CartLabels>();

  Widget build(BuildContext context) {
    _controller.renderListViewObs.value = true;
    return Scaffold(
        appBar: _appbar.create(_labels.titlePage, Get.back,
            actions: [ClearCartButton(_controller)]),
        body: Container(
            child: LayoutBuilder(builder: (_, constraint) {
          var _height = constraint.maxHeight;
          var _width = constraint.maxWidth;
          return Column(children: [
            CartViewHeader(_width, _height, _controller),
            SizedBox(height: _height * 0.01),
            _cartItemsList(_height, _width, _controller)
          ]);
        })));
  }

  Expanded _cartItemsList(double _height, double _width, CartController controller) {
    return Expanded(
        child: Obx(() => controller.renderListViewObs.value
            ? Container(
                width: _width * 0.93,
                child: CartStaggeredListview(
                  fadeEffect: false,
                  // invertTargetPosition: false,
                  verticalOffset: (_height * 0.625),
                ).listview(controller.getAllCartItems()))
            : Container(
                width: _width * 0.93,
                child: Stack(alignment: Alignment.center, children: [
                  CartStaggeredListview(
                    fadeEffect: false,
                    // horizontalOffset: (_height * 0.9),
                    // invertTargetPosition: true,
                    // verticalOffset: -(_height * 0.9),
                  ).listview(controller.getAllCartItems()),
                  // _transparentGradientShaderMask()
                ]))));
  }

  Widget _transparentGradientShaderMask() {
    return ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black, Colors.transparent],
          ).createShader(
              Rect.fromLTRB(0, 0, rect.width, rect.height * TRANSPARENCY_LAYER_LISTVIEW));
        },
        blendMode: BlendMode.dstIn,
        child: Container(color: Colors.white));
  }
}