import 'package:flutter/material.dart';

class InventoryIcons {
  final _APPBAR_ADD_BUTTON = Icon(Icons.add);
  final _TILE_EDIT_BUTTON = Icon(Icons.edit);
  final _TILE_DELETE_BUTTON = Icon(Icons.delete);

  Icon icon_update() => _TILE_EDIT_BUTTON;
  Icon icon_delete() => _TILE_DELETE_BUTTON;
  Icon ico_add_appbar() => _APPBAR_ADD_BUTTON;

}