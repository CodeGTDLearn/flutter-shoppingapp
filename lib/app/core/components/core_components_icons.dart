import 'package:flutter/material.dart';

class CoreComponentsIcons {
  final _PRODUCTS = Icon(Icons.format_list_bulleted);
  final _CART = Icon(Icons.shop);
  final _ORDERS = Icon(Icons.payment);
  final _INVENTORY = Icon(Icons.edit);
  final _SWITCHER_DARKTHEME = Icon(Icons.lightbulb_outline);
  final _NONE = Icon(Icons.hourglass_empty);

  Icon ico_cart() => _CART;

  Icon ico_ord() => _ORDERS;

  Icon ico_inv() => _INVENTORY;

  Icon ico_switch() => _SWITCHER_DARKTHEME;

  Icon ico_none() => _NONE;

  Icon ico_prods() => _PRODUCTS;
}