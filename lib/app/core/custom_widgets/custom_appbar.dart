import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class CustomAppBar {
  AppBar create(String title, Function backTapFunction, [List<Widget>? actions]) {
    return AppBar(
        title: Text(title),
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () => backTapFunction.call(),
          child: Icon(Icons.arrow_back),
        ),
        actions: actions);
  }
}