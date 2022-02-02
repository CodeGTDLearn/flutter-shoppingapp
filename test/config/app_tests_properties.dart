const DELAY = 2;
const EXTRA_DELAY = 2;

const TEST_SCREEN_SIZE_DX = 414.0;
const TEST_SCREEN_SIZE_DY = 896.0;

const WIDGET_TEST = 'widget_test';
const INTEGRATION_TEST = 'integration';

const ISOLATED_STATE_TITLE = ' - Isolated State';
const SHARED_STATE_TITLE = ' - Shared State';

final MOCKED_DATA_MASS_PATH_FILE = "test/config/datasource/mocked_data_mass.json";
const TESTDB_NAME = 'test-app-dev-e6ee1-default-rtdb';
const TESTDB_URL = "https://$TESTDB_NAME.firebaseio.com";
const TESTDB_ROOT_URL = "$TESTDB_URL/.json";
const TESTDB_PRODUCTS_URL = "$TESTDB_URL/products.json";
const TESTDB_ORDERS_URL = "$TESTDB_URL/orders.json";
const TESTDB_CART_ITEM_URL = "$TESTDB_URL/cart-items.json";

const TOTAL_SAMPLE_DATA_ITEMS = 5;
const TOTAL_CART_ITEMS_INSIDE_PRODUCTS_SAMPLE_DATA = 4;
const IMAGE_CORE_URL = 'https://images.freeimages.com/images/large-previews/';
const TEST_IMAGE_URL_MAP = {
  "Tomatoes": "${IMAGE_CORE_URL}294/tomatoes-1326096.jpg",
  "Shirt": "${IMAGE_CORE_URL}eae/clothes-3-1466560.jpg",
  "Cones": "${IMAGE_CORE_URL}792/cones-from-a-pinetree-1639246.jpg",
  "Fruit": "${IMAGE_CORE_URL}503/fruit-in-the-country-3-1323660.jpg",
  "Orange": "${IMAGE_CORE_URL}e7e/orange-portocaliu-1518994.jpg",
  "Dachshund": "${IMAGE_CORE_URL}006/young-dachshund-1362378.jpg",
  "Flower": "${IMAGE_CORE_URL}1f9/pink-flower-1641779.jpg",
  "CatV1": "${IMAGE_CORE_URL}704/hidden-cat-1641759.jpg",
  "CatV2": "${IMAGE_CORE_URL}3f2/cat-mother-protecting-its-baby-1641748.jpg",
  "CatV3": "${IMAGE_CORE_URL}867/cat-cartoon-art-1641753.png"
};