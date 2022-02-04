class InventoryLabels {
  final _INVENTORY_PAGE_TITLE = "Inventory";
  final _INVENTORY_EDIT_TITLEPAGE_ADD = "Add Product";
  final _INVENTORY_EDIT_TITLEPAGE_EDIT = "Edit Product";
  final _INVENTORY_EDIT_FIELD_TITLE = "Title";
  final _INVENTORY_EDIT_FIELD_PRICE = "Price";
  final _INVENTORY_EDIT_FIELD_DESCRIPT = "Description";
  final _INVENTORY_EDIT_IMAGE_TITLE = "Image";
  final _INVENTORY_EDIT_FIELD_IMAGE_URL = "Image URL";
  final _INVENTORY_EDIT_FIELD_BARCODE_URL = "Bar Code";
  final _INVENTORY_EDIT_DELETE_TITLE = "Inventory Deletion";
  final _INVENTORY_EDIT_DELETE_CONFIRMATION = "Really wanna remove: ";

  // FORM-HINTS
  final _HINT_PRICE_FIELD = "00.00";
  final _HINT_TITLE_FIELD = "title";
  final _HINT_DESCRIPTION_FIELD = "Description";
  final _HINT_URL_FIELD = "Image Url";

  get inv_tit_page => _INVENTORY_PAGE_TITLE;

  get inv_edt_lbl_add_appbar => _INVENTORY_EDIT_TITLEPAGE_ADD;

  get inv_edt_lbl_edit_appbar => _INVENTORY_EDIT_TITLEPAGE_EDIT;

  get inv_edt_lbl_title => _INVENTORY_EDIT_FIELD_TITLE;

  get inv_edt_lbl_price => _INVENTORY_EDIT_FIELD_PRICE;

  get inv_edt_lbl_descr => _INVENTORY_EDIT_FIELD_DESCRIPT;

  get inv_edt_lbl_imgurl => _INVENTORY_EDIT_FIELD_IMAGE_URL;

  get inv_edt_lbl_barcode => _INVENTORY_EDIT_FIELD_BARCODE_URL;

  get inv_edt_img_tit => _INVENTORY_EDIT_IMAGE_TITLE;

  get inv_edt_del_conf_tit => _INVENTORY_EDIT_DELETE_TITLE;

  get inv_edt_del_conf_message => _INVENTORY_EDIT_DELETE_CONFIRMATION;

  // FORM-HINTS
  get amount_hint => _HINT_PRICE_FIELD;

  get title_hint => _HINT_TITLE_FIELD;

  get descript_hint => _HINT_DESCRIPTION_FIELD;

  get url_hint => _HINT_URL_FIELD;
}