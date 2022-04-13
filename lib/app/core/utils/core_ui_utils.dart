import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class CoreUiUtils {
  double usefulHeight(BuildContext context, double superiorBar) {
    return MediaQuery.of(context).size.height -
        (screenBotton(context) + screenTop(context) + superiorBar);
  }

  double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double usefulWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double screenBotton(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  double screenTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  Size sizeNoContext() {
    return WidgetsBinding.instance!.window.physicalSize;
  }

  double devicePixelRatio() {
    return WidgetsBinding.instance!.window.devicePixelRatio;
  }

  void printDeviceSize() {
    print('This is the physical size of this device: ${sizeNoContext()}');
  }

  double physycalWidthNoContext() {
    return sizeNoContext().width;
  }

  double physicalHeightNoContext() {
    return sizeNoContext().height;
  }

  // UI-TEST-DIMENSIONS CONSIDERATIONS
//
// * EXPLANATIONS:
//   - FLUTTER:
//     + Uses "Logical Pixels" (not physical pixels)
//       -> LOGICAL PIXEL = 38 Pixel/centimeter
//       -> Flutter USES "LOGICAL PIXEL" in "ALL DEVICES/SCREENS"
//          => LOGICAL PIXEL allow find the same dimensions ALL SCREEN SIZES
//       -> Flutter "DOES NOT USES" physical pixels
//
//   - DevicePixelRatio:
//     + given in "Device Specs"
//
// * FORMULAS:
//   - DevicePixelRatio:
//     + Physical Pixels / Logical Pixels
//   - Find the Logical Pixels (FLUTTER):
//     + Physical Pixels (Size)  / DevicePixelRatio
  double logicalHeightNoContext() {
    return physicalHeightNoContext() / devicePixelRatio();
  }

  double logicalWidthNoContext() {
    return physycalWidthNoContext() / devicePixelRatio();
  }
}