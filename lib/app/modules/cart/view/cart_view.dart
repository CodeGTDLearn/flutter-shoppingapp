import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_appbar.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts/modules/cart.dart';
import '../components/cartview_header.dart';
import '../components/clear_cart_button.dart';
import '../components/custom_listview/cart_staggered_listview.dart';
import '../controller/cart_controller.dart';

class CartView extends StatelessWidget {
  final _controller = Get.find<CartController>();
  final _appbar = Get.find<CustomAppBar>();

  Widget build(BuildContext context) {
    _controller.renderListView.value = true;
    return Scaffold(
        appBar: _appbar
            .create(CRT_TIT_APPBAR, Get.back, actions: [ClearCartButton(_controller)]),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: LayoutBuilder(builder: (_, constraint) {
              var _height = constraint.maxHeight;
              var _width = constraint.maxWidth;
              return Column(children: [
                CartViewHeader(_width, _height, _controller),
                SizedBox(height: _height * 0.01),
                Expanded(
                    child: Obx(() => _controller.renderListView.value
                        ? Container(
                            child: CartStaggeredListview(
                            fadeEffect: false,
                            invertTargetPosition: false,
                            verticalOffset: (_height * 0.625),
                          ).customCartListview(_controller.getAllCartItems()))
                        : Container(
                            child: Stack(alignment: Alignment.center, children: [
                            CartStaggeredListview(
                              fadeEffect: false,
                              invertTargetPosition: true,
                              verticalOffset: -(_height * 0.564),
                            ).customCartListview(_controller.getAllCartItems()),
                            _transparentGradientShaderMask()
                          ]))))
              ]);
            })));
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