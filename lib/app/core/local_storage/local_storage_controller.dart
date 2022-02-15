import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopingapp/app/modules/cart/entity/cart_item.dart';

class LocalStorageController extends GetxController {
  final _localStorage = GetStorage();
  final _keyDarkMode = 'isDarkMode';
  final _keyLocalCartItems = 'localCartItems';
  var darkModelObs = true.obs;

  @override
  void onInit() {
    darkModelObs.value = _getTheme();
  }

  ThemeMode getTheme() => _getTheme() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_getTheme() ? ThemeMode.light : ThemeMode.dark);
    _saveTheme(!_getTheme());
    darkModelObs.value = _getTheme();
  }

  Map<String, CartItem> getCartItemsLocalStorage() {
    final keyHasData = _localStorage.hasData(_keyLocalCartItems);
    final keyData = _localStorage.read(_keyLocalCartItems);
    Map<String, dynamic> keyData_decode_FromString_toJson = jsonDecode(keyData);

    Map<String, CartItem> finalMap_ToBe_Returned = {};

    keyData_decode_FromString_toJson.forEach((key, value) {
      finalMap_ToBe_Returned.putIfAbsent(key, () => CartItem.fromJson(value));
    });

    return keyHasData ? finalMap_ToBe_Returned : {};
  }

  void saveCartItemsLocalStorage(Map<String, CartItem> cartItemList) {
    clearCartItemsLocalStorage();
    _localStorage.write(_keyLocalCartItems, jsonEncode(cartItemList));
  }

  void clearCartItemsLocalStorage() {
    _localStorage.remove(_keyLocalCartItems);
  }

  bool _getTheme() => _localStorage.read(_keyDarkMode) ?? false;

  void _saveTheme(bool isDarkMode) => _localStorage.write(_keyDarkMode, isDarkMode);
}