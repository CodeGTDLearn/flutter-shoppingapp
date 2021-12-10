import 'package:flutter/material.dart';

class AppListItem extends StatelessWidget {
  final GlobalKey imageGlobalKey = GlobalKey();
  final void Function(GlobalKey) onClick;

  AppListItem({required this.onClick});

  @override
  Widget build(BuildContext context) {
    Container mandatoryContainer = Container(
        key: imageGlobalKey,
        width: 60,
        height: 60,
        color: Colors.transparent,
        child: Image.asset("assets/apple.png", width: 60, height: 60));

    return GestureDetector(
      onTap: () => onClick(imageGlobalKey),
      child: GridTile(
        child: mandatoryContainer,
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