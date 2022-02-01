class CartTestTitles {
  String REPO_NAME = 'CartMockedRepo';

  //GROUP-TITLES ---------------------------------------------------------------
  static get GROUP_TITLE => 'Cart|Integration-Tests:';

  // MVC-TITLES ----------------------------------------------------------------
  get REPO_TITLE => '$REPO_NAME|Repo: Unit';

  get SERVICE_TITLE => '$REPO_NAME|Service: Unit';

  get CONTROLLER_TITLE => '$REPO_NAME|Controller: Integr';

  get VIEW_TITLE => '$REPO_NAME|View: Functional';

  // REPO-TITLES ---------------------------------------------------------------
  get repo_get_all_products => 'Getting ALL products from the Cart';

  get repo_remove_product => 'Removing specific products from the Cart';

  get repo_clear_cart => 'Clearing ALL products from the Cart';

  get repo_add_two_products => 'Adding two products in the Cart';

  get repo_undo_add_product => 'Undo added product';

  // SERVICE-TITLES ------------------------------------------------------------
  get service_get_all_products => 'Getting ALL products from the Cart';

  get service_remove_product => 'Removing specific products from the Cart';

  get service_clear_cart => 'Clearing ALL products from the Cart';

  get service_add_two_products => 'Adding two products in the Cart';

  get service_undo_add_product => 'Undo added product';

  get service_get_cartitem_qtde => 'Getting CartItems Quantity from the Cart';

  get service_get_cartitem_amount => 'Getting CartItems Amount\$ from the Cart';

  // CONTROLLER-TITLES  --------------------------------------------------------
  get controller_add_order => 'Adding Orders';

  get controller_get_cartitem_amount => 'Getting CartItems AmountObs\$ from the Cart';

  get controller_get_cartitem_qtde => 'Getting CartItems QuantityObs from the Cart';

  get controller_undo_add_product => 'Undo added product';

  get controller_add_two_products => 'Adding two products in the Cart';

  get controller_clear_cart => 'Clearing ALL products from the Cart';

  get controller_product => 'Removing specific products from the Cart';

  get controller_get_all_products => 'Getting ALL products from the Cart';

  // VIEW-TITLES ---------------------------------------------------------------
  get view_add_products => 'Adding products|Check CartPage';

  get view_add_product_check_snackbar => 'Adding product|Check Snackbar';

  get view_denying_dismissing_cartitem => 'Denying FIRST product Dismissing';

  get view_dismissing_first_product => 'Dismissing FIRST added product';

  get view_dismissing_all_products => 'Dismissing ALL products';

  get view_block_cartview_cartempty => 'Empty Cart|block Access to Cart Page';

  get view_open_cartview => 'Opening CartView|Checking 2 products';

  get view_check_amount_cart => 'Checking Amount Cart';

  get view_order_cartProducts_tap_orderNowButton => 'Order Product|Tap Order-Now-Button';

  get view_clear_cart_clear_button => 'Clearing Products|ClearCart IconButton';

  get view_backbutton => 'Testing Page BackButton';
}