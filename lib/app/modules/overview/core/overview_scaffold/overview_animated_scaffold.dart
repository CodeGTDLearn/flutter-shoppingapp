import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add To Cart Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OverviewAnimatedScaffold(title: 'Add To Cart Animation'),
    );
  }
}

class OverviewAnimatedScaffold extends StatefulWidget {
  OverviewAnimatedScaffold({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _OverviewAnimatedScaffoldState createState() => _OverviewAnimatedScaffoldState();
}

class _OverviewAnimatedScaffoldState extends State<OverviewAnimatedScaffold> {
  GlobalKey<CartIconKey> gkCart = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;

  @override
  Widget build(BuildContext context) {
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
      receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
        this.runAddToCardAnimation = addToCardAnimationMethod;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title), centerTitle: false, actions: [
          AddToCartIcon(key: gkCart, icon: Icon(Icons.shopping_cart)),
          SizedBox(width: 16)
        ]),
        body: Center(
          child: Container(
            child: GridView.count(
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              children: [
                AppListItem(onClick: listClick),
                AppListItem(onClick: listClick),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void listClick(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }
}