const BASE_URL = "https://my-first-shop-app-1db95-default-rtdb.firebaseio.com";
const BASE_URL_RETROFIT = "https://my-first-shop-app-1db95-default-rtdb"
    ".firebaseio.com/";

const COLLECTION_PRODUCTS = "products";
const COLLECTION_ORDERS = "orders";
const COLLECTION_CART_ITEMS = "cart-items";
const EXTENSION = ".json";

const PRODUCTS_URL = "$BASE_URL/$COLLECTION_PRODUCTS$EXTENSION";
const ORDERS_URL = "$BASE_URL/$COLLECTION_ORDERS$EXTENSION";
const CART_ITEM_URL = "$BASE_URL/$COLLECTION_CART_ITEMS$EXTENSION";

const PRODUCTS_URL_RETROFIT = "/$COLLECTION_PRODUCTS";
const ORDERS_URL_RETROFIT = "/$COLLECTION_ORDERS";
const CART_ITEM_URL_RETROFIT = "/$COLLECTION_CART_ITEMS";

