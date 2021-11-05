class CartTestTitles {
  String REPO_NAME = 'CartMockedRepo';

  // @formatter:off
  //GROUP-TITLES ---------------------------------------------------------------
  static get GROUP_TITLE => 'Cart|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  get REPO_TITLE => '$REPO_NAME|Repo: Unit';

  get SERVICE_TITLE => '$REPO_NAME|Service: Unit';

  get CONTROLLER_TITLE => '$REPO_NAME|Controller: Integr';

  get VIEW_TITLE => '$REPO_NAME|View: Functional';

  //TEST-TITLES ----------------------------------------------------------------
  get add_products_check_cartPage => 'Adding products|Check CartPage';

  get add_product_check_snackbar => 'Adding product|Check Snackbar';

  get denying_dismissing_cartitem => 'Denying FIRST product Dismissing';

  get dismissing_first_added_product => 'Dismissing FIRST added product';

  get dismissing_all_added_products => 'Dismissing ALL products';

  get emptycart_block_access_to_cartpage => 'Empty Cart|block Access to Cart Page';

  get open_cartpage_check2products => 'Opening CartView|Checking 2 products';

  get check_amount_cart => 'Checking Amount Cart';

  get order_cartProducts_tap_orderNowButton =>
      'Ordering Products|Tapping Order-Now-Button';

  get clear_cart_tap_clear_button => 'Clearing Products|ClearCart IconButton';

  get test_page_backbutton => 'Testing Page BackButton';

// @formatter:on
}