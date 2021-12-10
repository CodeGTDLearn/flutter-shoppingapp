import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/instance_manager.dart';
import 'package:shopingapp/app/modules/overview/core/overview_appbar/overview_appbar.dart';

import '../../../../core/keys/overview_keys.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../controller/overview_controller.dart';
import '../custom_grid_item/animated_grid_item.dart';

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Add To Cart Animation',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: AnimatedOverviewScaffold(title: 'Add To Cart Animation'),
//     );
//   }
// }

class AddCartScaffold extends StatefulWidget {
  final drawer;

  AddCartScaffold({Key? key, required this.drawer}) : super(key: key);

  @override
  _AddCartScaffoldState createState() => _AddCartScaffoldState();
}

class _AddCartScaffoldState extends State<AddCartScaffold> {
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  final _controller = Get.find<OverviewController>();
  final _cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _gridItems = _controller.gridItemsObs.value;
    final _appbar = Get.find<OverviewAppBar>(tag: 'appBarAddCart');
    // final _appbar = Get.put(OverviewAppBar(
    //   cart: AddToCartIcon(key: gkCart, icon: Icon(Icons.threed_rotation_sharp)),
    // ));

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
          drawer: widget.drawer,
          body: AnimationLimiter(
              child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(_gridItems.length, (index) {
                    return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 2,
                        child: ScaleAnimation(
                            duration: Duration(milliseconds: 500),
                            child: FadeInAnimation(
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnimatedGridItem(
                                      _gridItems.elementAt(index),
                                      index.toString(),
                                      onClick: listClick,
                                    )))));
                  })))

          // appBar: AppBar(
          //   title: Text(widget.title),
          //   centerTitle: false,
          //   actions: [
          //     AddToCartIcon(key: gkCart, icon: Icon(Icons.shopping_cart)),
          //     SizedBox(width: 16)
          //   ],
          // ),
          // body: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(
          //     child: Container(
          //       child: GridView.count(
          //         scrollDirection: Axis.vertical,
          //         crossAxisCount: 2,
          //         children: [
          //           AppListItem(onClick: listClick),
          //           AppListItem(onClick: listClick),
          //           AppListItem(onClick: listClick),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }

  void listClick(GlobalKey gkImageContainer) async {
    await runAddToCardAnimation(gkImageContainer);
    await gkCart.currentState!.runCartAnimation(
      _cartController.qtdeCartItemsObs.value.toString(),
    );
  }
}