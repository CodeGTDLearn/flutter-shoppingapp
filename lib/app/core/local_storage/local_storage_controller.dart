import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../modules/cart/entity/cart_item.dart';

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
    final cartItems = _localStorage.hasData(_keyLocalCartItems);
    var _localCartItems = <String, CartItem>{};

    if (cartItems) {
      var _getCartItems = _localStorage.read(_keyLocalCartItems);
      Map<String, dynamic> keyData_decode_FromString_toJson = jsonDecode(_getCartItems);
      keyData_decode_FromString_toJson.forEach((key, value) {
        _localCartItems.putIfAbsent(key, () => CartItem.fromJson(value));
      });
    }

    return cartItems ? _localCartItems : {};
  }

  void saveCartItemsLocalStorage(Map<String, CartItem> cartItemList) {
    clearCartItemsLocalStorage();
    _localStorage.write(_keyLocalCartItems, jsonEncode(cartItemList));
  }

  void clearCartItemsLocalStorage() {
    _localStorage.remove(_keyLocalCartItems);
  }

  Map<String, CartItem> removeCartItemsFromLocalStorage(String id) {
    final cartItems = _localStorage.hasData(_keyLocalCartItems);
    var _localItems = <String, CartItem>{};

    if (cartItems) {
      var _getCartItems = _localStorage.read(_keyLocalCartItems);
      Map<String, dynamic> keyData_decode_FromString_toJson = jsonDecode(_getCartItems);
      keyData_decode_FromString_toJson.forEach((key, value) {
        if (value.val(id) != id) _localItems.putIfAbsent(key, () => CartItem.fromJson(value));
      });
    }

    return cartItems ? _localItems : {};
  }

  bool _getTheme() => _localStorage.read(_keyDarkMode) ?? false;

  void _saveTheme(bool isDarkMode) => _localStorage.write(_keyDarkMode, isDarkMode);
}