import 'package:flutter/material.dart';

class OverviewIcons {
  final _APPBAR = Icon(Icons.shopping_cart);
  final _POPUP_APPBAR = Icon(Icons.more_vert);
  final _FAVORITES = Icon(Icons.favorite);
  final _NO_FAVORITES = Icon(Icons.favorite_border);
  final _FAVORITES_NOTIFICATION =
      Icon(Icons.notifications_active, color: Colors.white);

  Icon ico_fav() => _FAVORITES;

  Icon ico_nofav() => _NO_FAVORITES;

  Icon ico_shopcart() => _APPBAR;

  Icon ico_popup() => _POPUP_APPBAR;

  Icon ico_notif_fav() => _FAVORITES_NOTIFICATION;
}