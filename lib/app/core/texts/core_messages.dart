import '../properties/form_field_sizes.dart';

class CoreMessages {
  final _CART_ITEM_ADDED = " Added in the cart.";
  final _CART_ITEM_REMOVED = "Item removed successfully.";
  final _CART_NO_ITEMS_YET = "There is no CartItems, yet";
  final _CART_NO_ITEMS_SNACK = "No items in the cart, yet.";

  final _INVENTORY_NO_PRODUCTS_YET = "There is no products to be managed.";
  final _INVENTORY_PRODUCT_SUCESS_ADDITION = "The product was added successfuly.";
  final _INVENTORY_PRODUCT_SUCESS_UPDATE = "The product was updated successfuly.";
  final _INVENTORY_PRODUCT_SUCESS_REMOVED = "The product was deleted successfuly.";

  final _INVENTORY_DETAILS_UPDATE_STOCK_TITLE = "Updating Stock";
  final _INVENTORY_DETAILS_UPDATE_STOCK_ADDITION_HINT = "Addition amount";
  final _INVENTORY_DETAILS_UPDATE_STOCK_SUBTRACTION_HINT = "Subtraction amount";
  final _INVENTORY_DETAILS_EMPTY_FIELD_MESSAGE = "Please, fill the field.";
  final _INVENTORY_DETAILS_FORMAT_NUMBER_MESSAGE = "Please, provide a proper value.";
  final _INVENTORY_DETAILS_ONLY_TEXTNUMBER_MESSAGE =
      "Please, only text and number are allowed.";
  final _INVENTORY_DETAILS_CODE_READING_ERROR_MESSAGE = "Code Read not done";

  final _INVENTORY_DETAILS_FORMAT_PRICE_MESSAGE = "Please, type the price properly.";
  final _INVENTORY_DETAILS_FORMAT_URL_MESSAGE = "Please, provide proper URL.";
  final _INVENTORY_DETAILS_ZERO_PRODUCT_STOCK_MESSAGE =
      "The stock less than required - operation not done";
  final _INVENTORY_DETAILS_SIZE_05_INVAL_MESSAGE =
      "Allowed: $FIELD_TITLE_MIN_SIZE to $FIELD_TITLE_MAX_SIZE characters.";
  final _INVENTORY_DETAILS_SIZE_10_INVAL_MESSAGE =
      "Allowed: $FIELD_DESC_MIN_SIZE to $FIELD_DESCRIPT_MAX_SIZE characters.";
  final _INVENTORY_DETAILS_SIZE_URL_INVAL_MESSAGE =
      "Allowed: $FIELD_URL_MIN_SIZE to $FIELD_URL_MAX_SIZE characters.";
  final _INVENTORY_DETAILS_SIZE_PRICE_INVAL_MESSAGE =
      "Allowed: $FIELD_PRICE_MIN_SIZE to $FIELD_PRICE_MAX_SIZE characters.";

  //Getx Dialogs
  final _TRY_AGAIN_LATER = "Something wronged happens. Please, Try Again.";
  final _ORDER_SUCESS_ADDITION = "The order was added successfuly.";
  final _ORDER_CLEAN_SUCESS = "The order was cleaned successfuly.";

  //Database Empty
  final _OVERVIEW_DB_EMPTY_YET = 'There is no products to display.';

//CUSTOM CIRCULAR PROGRESS INDICATOR
  final _ADAPTIVE_INDICATOR_NO_ORDERS_YET = "There is no Orders, yet";
  final _ADAPTIVE_INDICATOR_NO_PRODUCTS_YET = "There is no Products, yet";
  final _ADAPTIVE_INDICATOR_NO_INVENT_PRODUCTS_YET =
      "There is no Products in Inventory, yet";
  final _ADAPTIVE_INDICATOR_FAVORITES_NOT_FOUND_YET = "Favorites not found, yet.";
  final _ADAPTIVE_INDICATOR_NO_ORDERS_DONE_YET = "No orders were done, yet.";

  //CUSTOM DRAWER MESSAGES
  // final DRAWER_COMPONENT_TEXT_CART_NO_PRODUCTS_YET = "No Products in the cart, Yet";
  // final DRAWER_COMPONENT_TEXT_NO_ORDERS_YET = "No Orders were done, Yet";
  // final DRAWER_COMPONENT_TEXT_NO_MANAGED_PRODUCTS_YET = "No Managed Products, Yet";

  get suces_ord_clean => _ORDER_CLEAN_SUCESS;

  get prod_add_stock_conf => _INVENTORY_DETAILS_UPDATE_STOCK_ADDITION_HINT;

  get suces_ord_add => _ORDER_SUCESS_ADDITION;

  get error_ord => _TRY_AGAIN_LATER;

  get item_removed_cart => _CART_ITEM_REMOVED;

  get no_orders_yet => _ADAPTIVE_INDICATOR_NO_ORDERS_YET;

  get no_products_yet => _ADAPTIVE_INDICATOR_NO_PRODUCTS_YET;

  get no_crtitem_yet => _CART_NO_ITEMS_YET;

  get no_inv_prod_yet => _ADAPTIVE_INDICATOR_NO_INVENT_PRODUCTS_YET;

  get drw_no_data_yet => _OVERVIEW_DB_EMPTY_YET;

  get cart_no_items_yet => _CART_NO_ITEMS_SNACK;

  get item_cart_added => _CART_ITEM_ADDED;

  get item_cart_removed => _CART_ITEM_REMOVED;

  get overview_no_favs_yet => _ADAPTIVE_INDICATOR_FAVORITES_NOT_FOUND_YET;

  get orders_done_yet => _ADAPTIVE_INDICATOR_NO_ORDERS_DONE_YET;

  get invNoItemsYet => _INVENTORY_NO_PRODUCTS_YET;

  get tog_status_error => _TRY_AGAIN_LATER;

  get tog_status_suces => _INVENTORY_PRODUCT_SUCESS_UPDATE;

  get error_inv_prod => _TRY_AGAIN_LATER;

  get suces_inv_prod_add => _INVENTORY_PRODUCT_SUCESS_ADDITION;

  get suces_inv_prod_upd => _INVENTORY_PRODUCT_SUCESS_UPDATE;

  get suces_inv_prod_del => _INVENTORY_PRODUCT_SUCESS_REMOVED;

  get inv_no_prod_yet => _OVERVIEW_DB_EMPTY_YET;

  get size_05_inval_mes => _INVENTORY_DETAILS_SIZE_05_INVAL_MESSAGE;

  get size_10_inval_mes => _INVENTORY_DETAILS_SIZE_10_INVAL_MESSAGE;

  get size_url_inval_mes => _INVENTORY_DETAILS_SIZE_URL_INVAL_MESSAGE;

  get size_price_inval_mes => _INVENTORY_DETAILS_SIZE_PRICE_INVAL_MESSAGE;

  get empty_field_msg => _INVENTORY_DETAILS_EMPTY_FIELD_MESSAGE;

  get format_number_message => _INVENTORY_DETAILS_FORMAT_NUMBER_MESSAGE;

  get only_textnumber_message => _INVENTORY_DETAILS_ONLY_TEXTNUMBER_MESSAGE;

  get format_price_message => _INVENTORY_DETAILS_FORMAT_PRICE_MESSAGE;

  get format_url_message => _INVENTORY_DETAILS_FORMAT_URL_MESSAGE;

  get size_05_inval_message => _INVENTORY_DETAILS_SIZE_05_INVAL_MESSAGE;

  get size_10_inval_message => _INVENTORY_DETAILS_SIZE_10_INVAL_MESSAGE;

  get size_url_inval_message => _INVENTORY_DETAILS_SIZE_URL_INVAL_MESSAGE;

  get zero_stock_message => _INVENTORY_DETAILS_ZERO_PRODUCT_STOCK_MESSAGE;

  get update_stock_title => _INVENTORY_DETAILS_UPDATE_STOCK_TITLE;

  get stock_addition_hint => _INVENTORY_DETAILS_UPDATE_STOCK_ADDITION_HINT;

  get stock_subtraction_hint => _INVENTORY_DETAILS_UPDATE_STOCK_SUBTRACTION_HINT;

  get code_read_error_message => _INVENTORY_DETAILS_CODE_READING_ERROR_MESSAGE;
// String DRW_TXT_NO_MAN_PROD_YET() => DRAWER_COMPONENT_TEXT_NO_MANAGED_PRODUCTS_YET;

// String DRW_TXT_CART() => DRAWER_COMPONENT_TEXT_CART_NO_PRODUCTS_YET;

// String DRW_TXT_ORD() => DRAWER_COMPONENT_TEXT_NO_ORDERS_YET;
}