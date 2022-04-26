import 'package:flutter/material.dart';

class InventoryKeys {
  final _INVENTORY_ADDEDIT_VIEW_FORM_GLOBALKEY = GlobalKey<FormState>();
  final _INVENTORY_APPBAR_ADD_BUTTON_KEY = 'inventory_appbar_addbutton_key';
  final _INVENTORY_DELETE_BUTTON_KEY = 'inventory_deleteitem_button_key';
  final _INVENTORY_ITEM_KEY = 'inventory_item_key';
  final _INVENTORY_UPDATE_BUTTON_KEY = 'inventory_updateitem_button_key';
  final _INVENTORY_EDIT_VIEW_SAVE_BUTTON_KEY = 'inventory_edit_savebutton_key';
  final _INVENTORY_EDIT_VIEW_FIELD_TITLE_KEY = 'inventory_edit_field_title_key';
  final _INVENTORY_EDIT_VIEW_FIELD_PRICE_KEY = 'inventory_edit_field_price_key';
  final _INVENTORY_EDIT_VIEW_FIELD_DESCRIPT_KEY = 'inventory_edit_field_descript_key';
  final _INVENTORY_EDIT_VIEW_FIELD_URL_KEY = 'inventory_edit_field_url_key';
  final _INVENTORY_EDIT_VIEW_FIELD_ARRIVAL_DATE_KEY = 'inventory_edit_field_arrivdate_key';
  final _INVENTORY_EDIT_VIEW_FIELD_EXPIRATION_DATE_KEY = 'inventory_edit_field_expdate_key';
  final _INVENTORY_EDIT_BARCODE_FIELD_KEY = 'inventory_edit_field_barcode_key';

  get k_inv_edit_barcode_fld => _INVENTORY_EDIT_BARCODE_FIELD_KEY;

  get k_inv_add_btn_appbar => _INVENTORY_APPBAR_ADD_BUTTON_KEY;

  get k_inv_del_btn => _INVENTORY_DELETE_BUTTON_KEY;

  get k_inv_upd_btn => _INVENTORY_UPDATE_BUTTON_KEY;

  get k_inv_item_key => _INVENTORY_ITEM_KEY;

  get k_inv_edit_save_btn => _INVENTORY_EDIT_VIEW_SAVE_BUTTON_KEY;

  get k_inv_form_gkey => _INVENTORY_ADDEDIT_VIEW_FORM_GLOBALKEY;

  get k_inv_edit_fld_title => _INVENTORY_EDIT_VIEW_FIELD_TITLE_KEY;

  get k_inv_edit_fld_price => _INVENTORY_EDIT_VIEW_FIELD_PRICE_KEY;

  get k_inv_edit_fld_descr => _INVENTORY_EDIT_VIEW_FIELD_DESCRIPT_KEY;

  get k_inv_edit_fld_imgurl => _INVENTORY_EDIT_VIEW_FIELD_URL_KEY;

  get k_inv_arr_date_fld => _INVENTORY_EDIT_VIEW_FIELD_ARRIVAL_DATE_KEY;

  get k_inv_exp_date_fld => _INVENTORY_EDIT_VIEW_FIELD_EXPIRATION_DATE_KEY;
}