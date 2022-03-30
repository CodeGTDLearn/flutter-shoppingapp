class CartLabels {
  final _CART_TITLE_PAGE = "Your Cart";
  final _CART_LABEL_CARD = "Total";
  final _CART_LABEL_ORDER_NOW = "Order Now";
  final _CART_LABEL_KEEP_SHOP = "Keep Shopping";
  final _CART_TOOLTIP_CLEAR_ALL = "Clear All";

  final _CART_ITEM_REMOVING_BLOCKED = "This product is not in the Cart, anymore.";
  final _CART_ITEM_ADDING_BLOCKED = "This product is not in the Stock, anymore.";
  final _CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM = "Are you sure?";
  final _CART_MESSAGE_ALERTDIALOG_DISMISS_CONFIRM = "Do you really want remove: ";
  final _CART_MESSAGE_ALERTDIALOG_CLEAR_ALL = "Do you really want clear the cart?";
  final _CART_MESSAGE_ALERTDIALOG_ORDER_NOW = "Do you want Add your Order?";
  final _ONLY_UNAVAILABLE_ITEMS_ORDER_IMPOSSIBLE =
      "All Items are unavailable. Try again later.";

  get allItemUnavailable => _ONLY_UNAVAILABLE_ITEMS_ORDER_IMPOSSIBLE;

  get titlePage => _CART_TITLE_PAGE;

  get cardCart => _CART_LABEL_CARD;

  get orderNowBtn => _CART_LABEL_ORDER_NOW;

  get keepShop => _CART_LABEL_KEEP_SHOP;

  get tootipClearCart => _CART_TOOLTIP_CLEAR_ALL;

  get titleDialogDismis => _CART_LABEL_ALERTDIALOG_DISMIS_CONFIRM;

  get messageDialogDismis => _CART_MESSAGE_ALERTDIALOG_DISMISS_CONFIRM;

  get dialogClearAll => _CART_MESSAGE_ALERTDIALOG_CLEAR_ALL;

  get dialogOrderNow => _CART_MESSAGE_ALERTDIALOG_ORDER_NOW;

  get cartItemAbsent => _CART_ITEM_REMOVING_BLOCKED;

  get noCartItemProductInStock => _CART_ITEM_ADDING_BLOCKED;

}