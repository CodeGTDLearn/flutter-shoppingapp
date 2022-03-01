import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/components/appbar/core_appbar.dart';
import '../../../core/components/badge/core_badge_cart.dart';
import '../../../core/components/core_adaptive_widgets.dart';
import '../../../core/properties/properties.dart';
import '../../../core/texts/core_labels.dart';
import '../../../core/utils/core_animations_utils.dart';
import '../../../core/utils/core_ui_utils.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/overview_controller.dart';
import '../core/overview_keys.dart';
import '../core/overview_labels.dart';

// ignore: must_be_immutable
class OverviewItemDetailsView extends StatelessWidget {
  String? _id;

  final _controller = Get.find<OverviewController>();
  final _cartController = Get.find<CartController>();
  final _animations = Get.find<CoreAnimationsUtils>();
  final _appbar = Get.find<CoreAppBar>();
  final _uiUtils = Get.find<CoreUiUtils>();
  final _widgetUtils = Get.find<CoreAdaptiveWidgets>();
  var cart = Get.find<CoreBadgeCart>();
  final _labels = Get.find<OverviewLabels>();
  final _coreLabels = Get.find<CoreLabels>();
  final _keys = Get.find<OverviewKeys>();

  OverviewItemDetailsView([this._id]);

  @override
  Widget build(BuildContext context) {
    if (_id == null) _id = Get.parameters['id'];
    var _product = _controller.getProductById(_id!);
    var _appBar = _appbar.create(_product.title, Get.back, actions: [cart]);
    var _appbarZoomPage = _appbar.create(
      _labels.detail_return_btn,
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              // color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 10.0)
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: GestureDetector(
                                onTap: _controller.toggleOverviewItemDetailsImageZoomObs,
                                child: FadeInImage(
                                    key: Key(_keys.k_ov_itm_det_page_img()),
                                    placeholder: AssetImage(IMAGE_PLACEHOLDER),
                                    image: NetworkImage(_product.imageUrl),
                                    fit: BoxFit.cover)),
                          )),
                      SizedBox(height: _height * 0.03),
                      Text('${_product.title}',
                          style: TextStyle(fontSize: _height * 0.03)),
                      SizedBox(height: _height * 0.03),
                      Text('${_coreLabels.currency} ${_product.price}',
                          style: TextStyle(fontSize: _height * 0.03)),
                      SizedBox(height: _height * 0.03),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: _height * 0.2,
                          width: double.infinity,
                          child: Text(_product.description,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2)),
                      SizedBox(height: _height * 0.03),
                      Text('${_coreLabels.available}: ${_product.stockQtde}',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(height: _height * 0.03),
                      Container(
                          height: _height * 0.1,
                          width: _width * 0.5,
                          color: Colors.red,
                          child: _widgetUtils.elevatedButton(
                              onPressed: () => _cartController.addCartItem(_product),
                              text: _labels.buy_btn,
                              textStyle: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)))),
                      SizedBox(height: _height * 0.1),
                    ]))))));
  }
}