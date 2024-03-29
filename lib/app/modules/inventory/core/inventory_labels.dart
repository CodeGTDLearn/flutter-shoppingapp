class InventoryLabels {
  final _INVENTORY_PAGE_TITLE = "Inventory";
  final _INVENTORY_EDIT_TITLEPAGE_ADD = "Add Product";
  final _INVENTORY_EDIT_TITLEPAGE_EDIT = "Edit Product";
  final _INVENTORY_EDIT_FIELD_TITLE = "Title";
  final _INVENTORY_EDIT_FIELD_PRICE = "Price";
  final _INVENTORY_EDIT_FIELD_DESCRIPT = "Description";
  final _INVENTORY_EDIT_IMAGE_TITLE = "Image";
  final _INVENTORY_EDIT_FIELD_IMAGE_URL = "Image URL";
  final _INVENTORY_EDIT_FIELD_CODE = "BarCode | QRCode";
  final _INVENTORY_EDIT_FIELD_ARRIVAL_DATE = "Arrival";
  final _INVENTORY_EDIT_FIELD_EXPIRATION_DATE = "Expiration";
  final _INVENTORY_EDIT_DELETE_TITLE = "Inventory Deletion";
  final _INVENTORY_EDIT_DELETE_CONFIRMATION = "Really wanna remove: ";

  // FORM-HINTS
  final _HINT_PRICE_FIELD = "00.00";
  final _HINT_TITLE_FIELD = "title";
  final _HINT_DESCRIPTION_FIELD = "Description";
  final _HINT_URL_FIELD = "Image Url";
  final _INVENTORY_EDIT_QRCODE_HINT = "QRCode";
  final _INVENTORY_EDIT_BARCODE_HINT = "BarCode";
  final _DISCOUNT_LABEL = 'Discount';
  final _INVENTORY_QRCODE_READ_AGAIN = "Read Again!!!";

  get inv_tit_page => _INVENTORY_PAGE_TITLE;

  get inv_edt_lbl_add_appbar => _INVENTORY_EDIT_TITLEPAGE_ADD;

  get inv_edt_lbl_edit_appbar => _INVENTORY_EDIT_TITLEPAGE_EDIT;

  get inv_edt_lbl_title => _INVENTORY_EDIT_FIELD_TITLE;

  get inv_edt_lbl_price => _INVENTORY_EDIT_FIELD_PRICE;

  get inv_edt_lbl_descr => _INVENTORY_EDIT_FIELD_DESCRIPT;

  get inv_edt_lbl_imgurl => _INVENTORY_EDIT_FIELD_IMAGE_URL;

  get inv_edt_lbl_code => _INVENTORY_EDIT_FIELD_CODE;

  get inv_edt_img_tit => _INVENTORY_EDIT_IMAGE_TITLE;

  get inv_edt_del_conf_tit => _INVENTORY_EDIT_DELETE_TITLE;

  get inv_edt_del_conf_message => _INVENTORY_EDIT_DELETE_CONFIRMATION;

  // FORM-HINTS
  get amount_hint => _HINT_PRICE_FIELD;

  get title_hint => _HINT_TITLE_FIELD;

  get descript_hint => _HINT_DESCRIPTION_FIELD;

  get url_hint => _HINT_URL_FIELD;

  get barcode_hint => _INVENTORY_EDIT_BARCODE_HINT;

  get qrcode_hint => _INVENTORY_EDIT_QRCODE_HINT;

  get discountLabel => _DISCOUNT_LABEL;

  get inv_arr_date_fld_lbl => _INVENTORY_EDIT_FIELD_ARRIVAL_DATE;

  get inv_exp_date_fld_lbl => _INVENTORY_EDIT_FIELD_EXPIRATION_DATE;

  get read_again => _INVENTORY_QRCODE_READ_AGAIN;
}