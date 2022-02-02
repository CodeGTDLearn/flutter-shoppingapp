import '../properties/form_field_sizes.dart';

class GlobalMessages {
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

  get suces_ord_clean => _ORDER_CLEAN_SUCESS;

  get suces_ord_add => _ORDER_SUCESS_ADD;

  get error_ord => _TRY_AGAIN_LATER;

  get item_removed_cart => _ITEM_REMOVED_FROM_CART;

  get no_orders_yet => _NO_ORDERS_YET;

  get no_products_yet => _NO_PRODUCTS_YET;

  get no_crtitem_yet => _NO_CART_ITEMS_YET;

  get no_inv_prod_yet => _NO_INVENT_PRODUCTS_YET;

  get drw_no_data_yet => _DB_EMPTY_YET;

  get cart_no_items_yet => _NO_ITEMS_IN_CART_YET;

  get item_cart_added => _ITEM_ADDED_IN_CART;

  get item_cart_removed => _ITEM_REMOVED_FROM_CART;

  get overview_no_favs_yet => _FAVORITES_NOT_FOUND_YET;

  get orders_done_yet => _NO_ORDERS_DONE_YET;

  get inventory_no_items_yet => _NO_INVENTORY_PRODUCTS_YET;

  get tog_status_error => _TRY_AGAIN_LATER;

  get tog_status_suces => _PRODUCT_SUCESS_UPD;

  get error_inv_prod => _TRY_AGAIN_LATER;

  get suces_inv_prod_add => _PRODUCT_SUCESS_ADD;

  get suces_inv_prod_upd => _PRODUCT_SUCESS_UPD;

  get suces_inv_prod_del => _PRODUCT_SUCESS_DEL;

  get inv_no_prod_yet => _DB_EMPTY_YET;

  get size_05_inval_mes => _SIZE_05_INVAL_MESSAGE;

  get size_10_inval_mes => _SIZE_10_INVAL_MESSAGE;

  get size_url_inval_mes => _SIZE_URL_INVAL_MESSAGE;

  get size_price_inval_mes => _SIZE_PRICE_INVAL_MESSAGE;

  get empty_field_msg => _EMPTY_FIELD_MESSAGE;

  get format_number_message => _FORMAT_NUMBER_MESSAGE;

  get only_textnumber_message => _ONLY_TEXTNUMBER_MESSAGE;

  get format_price_message => _FORMAT_PRICE_MESSAGE;

  get format_url_message => _FORMAT_URL_MESSAGE;

  get size_05_inval_message => _SIZE_05_INVAL_MESSAGE;

  get size_10_inval_message => _SIZE_10_INVAL_MESSAGE;

  get size_url_inval_message => _SIZE_URL_INVAL_MESSAGE;

// String DRW_TXT_NO_MAN_PROD_YET() => DRAWER_COMPONENT_TEXT_NO_MANAGED_PRODUCTS_YET;

// String DRW_TXT_CART() => DRAWER_COMPONENT_TEXT_CART_NO_PRODUCTS_YET;

// String DRW_TXT_ORD() => DRAWER_COMPONENT_TEXT_NO_ORDERS_YET;
}