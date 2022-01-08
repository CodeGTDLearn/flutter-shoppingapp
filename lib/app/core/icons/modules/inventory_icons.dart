import 'package:flutter/material.dart';

class InventoryIcons {
  //INVENTORY-VIEW
  final _APPBAR_ADD_BUTTON = Icon(Icons.add);
  final _TILE_EDIT_BUTTON = Icon(Icons.edit);
  final _TILE_DELETE_BUTTON = Icon(Icons.delete);

// INVENTORY-DETAILS-VIEW
  final _EDIT_SAVE_BUTTON_APPBAR = Icon(Icons.save);
  final _EDIT_NO_IMAGE_TITLE = Icon(Icons.image_outlined);

  Icon icon_update() => _TILE_EDIT_BUTTON;

  Icon icon_delete() => _TILE_DELETE_BUTTON;

  Icon ico_add_appbar() => _APPBAR_ADD_BUTTON;

  Icon ico_btn_appbar() => _EDIT_SAVE_BUTTON_APPBAR;

  Icon ico_edt_no_img() => _EDIT_NO_IMAGE_TITLE;
}