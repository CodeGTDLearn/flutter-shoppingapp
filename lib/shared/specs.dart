import 'dart:io';

import 'package:flutter/material.dart';

class Specs {
  BuildContext _context;

  //armazena uma instancia da propria classe Specs
  static Specs _instance;

  //construtor oculto
  Specs._singletonConstructor(this._context);

  factory Specs(context) {
    //se NAO ENCONTRA uma instancia em _instance,
    //cria instancia em _instance usando singletonContructor
    _instance ??= Specs._singletonConstructor(context);

    //se ENCONTRA uma instancia em _instance, simplesmente a retorna
    return _instance;
  }

  bool get isLandscape {
    return MediaQuery.of(this._context).orientation == Orientation.landscape;
  }

  String get deviceType {
    return Platform.isWindows
        ? "windows"
        : Platform.isMacOS
            ? "macos"
            : Platform.isLinux
                ? "linux"
                : Platform.isIOS
                    ? "ios"
                    : Platform.isAndroid
                        ? "android"
                        : Platform.isFuchsia ? "fuchsia" : "no-platform-found";
  }

  double bodyHeight() {
    return (fullHeight() -
        (kToolbarHeight +
            MediaQuery.of(this._context).padding.top +
            MediaQuery.of(this._context).padding.bottom));
  }

  double fullWidth() {
    return MediaQuery.of(this._context).size.width;
  }

  double fullHeight() {
    return MediaQuery.of(this._context).size.height;
  }

  double width(double ratio) {
    return fullWidth() * (ratio / 100);
  }

  double radius(double ratio) {
    return fullWidth() * (ratio / 100);
  }

  double height(double ratio) {
    return bodyHeight() * (ratio / 100);
  }
}
