import 'package:flutter/material.dart';

class AppListItem extends StatelessWidget {
  final GlobalKey imageGlobalKey = GlobalKey();
  final void Function(GlobalKey) onClick;

  AppListItem({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(imageGlobalKey),
      child: GridTile(
        // child: Image.asset(
        //   "assets/apple.png",
        //   key: imageGlobalKey,
        //   width: 30,
        //   height: 30,
        // ),
        child: Image.network(
          "https://images.freeimages.com/images/large-previews/eae/clothes-3-1466560.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
    // Image image =
    //     Image.asset("assets/apple.png", key: imageGlobalKey, width: 60, height: 60);
    // return ListTile(
    //   onTap: () => onClick(imageGlobalKey),
    //   leading: Container(child: image),
    //   title: FutureBuilder(
    //     future: Future.value(Rect.zero),
    //     initialData: Rect.zero,
    //     builder: (_, snapshot) {
    //       return Text(snapshot.data.toString());
    //     },
    //   ),
    // );
  }
}