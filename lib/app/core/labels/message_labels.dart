import '../properties/form_field_sizes.dart';

class MessageLabels {
  final _ITEM_ADDED_IN_CART = " Added in the cart.";
  final _ITEM_REMOVED_FROM_CART = "Item removed successfully.";
  final _NO_INVENTORY_PRODUCTS_YET = "There is no products to be managed.";

//Getx Dialogs
  final _TRY_AGAIN_LATER = "Something wronged happens. Please, Try Again.";
  final _PRODUCT_SUCESS_ADD = "The product was added successfuly.";
  final _PRODUCT_SUCESS_UPD = "The product was updated successfuly.";
  final _PRODUCT_SUCESS_DEL = "The product was deleted successfuly.";
  final _ORDER_SUCESS_ADD = "The order was added successfuly.";
  final _ORDER_CLEAN_SUCESS = "The order was cleaned successfuly.";
  final _CART_NO_ITEMS_ANYMORE = "There is no products in cart anymore.";

//Database Empty
  final _DB_EMPTY_YET = 'There is no products to display.';

//Field Form Validation - General Messages
  final _EMPTY_FIELD_MESSAGE = "Please, fill the field.";
  final _FORMAT_NUMBER_MESSAGE = "Please, provide a proper value.";
  final _ONLY_TEXTNUMBER_MESSAGE = "Please, only text and number are allowed.";
  final _FORMAT_PRICE_MESSAGE = "Please, type the price properly.";
  final _FORMAT_URL_MESSAGE = "Please, provide proper URL.";

//CUSTOM CIRCULAR PROGRESS INDICATOR
  final _NO_ORDERS_YET = "There is no Orders, yet";
  final _NO_PRODUCTS_YET = "There is no Products, yet";
  final _NO_CART_ITEMS_YET = "There is no CartItems, yet";
  final _NO_INVENT_PRODUCTS_YET = "There is no Products in Inventory, yet";
  final _NO_ITEM_IN_DB_YET = "No items in the DB, yet.";
  final _NO_ITEMS_IN_CART_YET = "No items in the cart, yet.";
  final _FAVORITES_NOT_FOUND_YET = "Favorites not found, yet.";
  final _NO_ORDERS_DONE_YET = "No orders were done, yet.";
  // final DRAWER_COMPONENT_TEXT_CART_NO_PRODUCTS_YET = "No Products in the cart, Yet";
  // final DRAWER_COMPONENT_TEXT_NO_ORDERS_YET = "No Orders were done, Yet";
  // final DRAWER_COMPONENT_TEXT_NO_MANAGED_PRODUCTS_YET = "No Managed Products, Yet";

//CUSTOM DRAWER MESSAGES

  //Field Form Validation - Specific Messages
  final _SIZE_05_INVAL_MESSAGE =
      "Allowed: $FIELD_TITLE_MIN_SIZE to $FIELD_TITLE_MAX_SIZE characters.";
  final _SIZE_10_INVAL_MESSAGE =
      "Allowed: $FIELD_DESC_MIN_SIZE to $FIELD_DESCRIPT_MAX_SIZE characters.";
  final _SIZE_URL_INVAL_MESSAGE =
      "Allowed: $FIELD_URL_MIN_SIZE to $FIELD_URL_MAX_SIZE characters.";
  final _SIZE_PRICE_INVAL_MESSAGE =
      "Allowed: $FIELD_PRICE_MIN_SIZE to $FIELD_PRICE_MAX_SIZE characters.";

  String suces_ord_clean() => _ORDER_CLEAN_SUCESS;

  String suces_ord_add() => _ORDER_SUCESS_ADD;

  String error_ord() => _TRY_AGAIN_LATER;

  String item_removed_cart() => _ITEM_REMOVED_FROM_CART;

  String no_orders_yet() => _NO_ORDERS_YET;

  String no_products_yet() => _NO_PRODUCTS_YET;

  String no_crtitem_yet() => _NO_CART_ITEMS_YET;

  String no_inv_prod_yet() => _NO_INVENT_PRODUCTS_YET;

  String drw_no_data_yet() => _DB_EMPTY_YET;

  String cart_no_items_yet() => _NO_ITEMS_IN_CART_YET;

  String item_cart_added() => _ITEM_ADDED_IN_CART;

  String item_cart_removed() => _ITEM_REMOVED_FROM_CART;

  String overview_no_favs_yet() => _FAVORITES_NOT_FOUND_YET;

  String orders_done_yet() => _NO_ORDERS_DONE_YET;

  String inventory_no_items_yet() => _NO_INVENTORY_PRODUCTS_YET;

  String tog_status_error() => _TRY_AGAIN_LATER;

  String tog_status_suces() => _PRODUCT_SUCESS_UPD;

  String error_inv_prod() => _TRY_AGAIN_LATER;

  String suces_inv_prod_add() => _PRODUCT_SUCESS_ADD;

  String suces_inv_prod_upd() => _PRODUCT_SUCESS_UPD;

  String suces_inv_prod_del() => _PRODUCT_SUCESS_DEL;

  String inv_no_prod_yet() => _DB_EMPTY_YET;

  String size_05_inval_mes() => _SIZE_05_INVAL_MESSAGE;

  String size_10_inval_mes() => _SIZE_10_INVAL_MESSAGE;

  String size_url_inval_mes() => _SIZE_URL_INVAL_MESSAGE;

  String size_price_inval_mes() => _SIZE_PRICE_INVAL_MESSAGE;

  String empty_field_msg() => _EMPTY_FIELD_MESSAGE;

  String format_number_message() => _FORMAT_NUMBER_MESSAGE;

  String only_textnumber_message() => _ONLY_TEXTNUMBER_MESSAGE;

  String format_price_message() => _FORMAT_PRICE_MESSAGE;

  String format_url_message() => _FORMAT_URL_MESSAGE;

  String size_05_inval_message() => _SIZE_05_INVAL_MESSAGE;

  String size_10_inval_message() => _SIZE_10_INVAL_MESSAGE;

  String size_url_inval_message() => _SIZE_URL_INVAL_MESSAGE;

  // String DRW_TXT_NO_MAN_PROD_YET() => DRAWER_COMPONENT_TEXT_NO_MANAGED_PRODUCTS_YET;

  // String DRW_TXT_CART() => DRAWER_COMPONENT_TEXT_CART_NO_PRODUCTS_YET;

  // String DRW_TXT_ORD() => DRAWER_COMPONENT_TEXT_NO_ORDERS_YET;
}