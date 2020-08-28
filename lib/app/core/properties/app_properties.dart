//GENERAL PROPERTIES
const APP_TITLE = "MyShopp";
const APP_DEBUG_CHECK = false;

//FLUSHBAR + GETX-SNACKBAR
const INTERVAL = 2000;

//DATE-FORMATS
//ORDERS-ITEM
const DATE_FORMAT = 'dd MMM yyyy - hh:mm';

//API PARAMETERS
const BASE_URL = "https://flutter-shoppingapp-86614.firebaseio.com";
const COLLECTION_PRODUCTS = "products";
const COLLECTION_ORDERS = "orders";
const COLLECTION_CART_ITEMS = "cart-items";
const PRODUCTS_URL = "$BASE_URL/$COLLECTION_PRODUCTS.json";
const ORDERS_URL = "$BASE_URL/$COLLECTION_ORDERS.json";
const CART_ITEM_URL = "$BASE_URL/$COLLECTION_CART_ITEMS.json";
const TIME_OUT = 5000;
