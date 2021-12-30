import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopingapp/app/core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';

import '../../../core/custom_widgets/custom_appbar.dart';
import '../../../core/keys/overview_keys.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/utils/animations_utils.dart';
import '../../../core/utils/ui_utils.dart';
import '../../../core/utils/widget_platform_utils.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/overview_controller.dart';
import '../core/overview_appbar/badge_cart.dart';

// ignore: must_be_immutable
class OverviewItemDetailsView extends StatelessWidget {
  String? _id;

  final _controller = Get.find<OverviewController>();
  final _cartController = Get.find<CartController>();
  final _animations = Get.find<AnimationsUtils>();
  final _appbar = Get.find<CustomAppBar>();
  final _uiUtils = Get.find<UiUtils>();
  final _widgetUtils = Get.find<WidgetPlatformUtils>();
  var cart = Get.find<BadgeCart>();

  OverviewItemDetailsView([this._id]);

  @override
  Widget build(BuildContext context) {
    if (_id == null) _id = Get.parameters['id'];
    var _product = _controller.getProductById(_id!);
    var _appBar = _appbar.create(_product.title, Get.back, actions: [cart]);
    var _appbarZoomPage = _appbar.create(
      'Click to return',
      _controller.toggleOverviewItemDetailsImageZoomObs,
      icon: Icons.zoom_out,
    );
    var _height = _uiUtils.usefulHeight(context, _appBar.preferredSize.height);
    var _width = _uiUtils.usefulWidth(context);

    return Obx(() => Scaffold(
        appBar:
            _controller.overviewItemDetailsImageZoomObs.value ? _appbarZoomPage : _appBar,
        body: _animations.zoomPageTransitionSwitcher(
            reverse: !_controller.overviewItemDetailsImageZoomObs.value,
            milliseconds: 1000,
            zoomObservable: _controller.overviewItemDetailsImageZoomObs,
            title: _product.title,
            imageUrl: _product.imageUrl,
            observableToggleMethod: _controller.toggleOverviewItemDetailsImageZoomObs,
            closeBuilder: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      Container(
                          height: _height * 0.3,
                          width: double.infinity,
                          child: GestureDetector(
                              onTap: _controller.toggleOverviewItemDetailsImageZoomObs,
                              child: FadeInImage(
                                key: Key(K_OV_ITM_DET_PAGE_IMG),
                                placeholder: AssetImage(IMAGE_PLACEHOLDER),
                                image: NetworkImage(_product.imageUrl),
                                fit: BoxFit.cover,
                              ))),
                      SizedBox(height: _height * 0.03),
                      Text('${_product.title}',
                          style: TextStyle(fontSize: _height * 0.03)),
                      SizedBox(height: _height * 0.03),
                      Text('\$${_product.price}',
                          style: TextStyle(fontSize: _height * 0.03)),
                      SizedBox(height: _height * 0.03),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: _height * 0.3,
                          width: double.infinity,
                          child: Text(_product.description,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2)),
                      SizedBox(height: _height * 0.03),
                      Container(
                          height: _height * 0.1,
                          width: _width * 0.5,
                          color: Colors.red,
                          child: _widgetUtils.button(
                              onpressed: () => _cartController.addCartItem(_product),
                              child: Text(OV_DET_BUY_BTN,
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontSize: 25,
                                          letterSpacing: .5,
                                          fontWeight: FontWeight.normal))))),
                      SizedBox(height: _height * 0.1),
                    ]))))));
  }
}