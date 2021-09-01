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
  get add_product_check_appbar_shopCart => 'Adding products + Check Appbar CartIcon Qtde';
  get add_product_check_cartPage => 'Adding product + Check in CartPage';
  get add_product_check_snackbar => 'Adding product + Check Snackbar';
  get deny_first_product_dismissing => 'Denying FIRST product Dismissing';
  get dismissing_first_product_added => 'Dismissing FIRST added product';
  get dismissing_second_last_product_added => 'Dismissing SECOND/LAST added product';
  get no_products_no_access_cartPage => 'No products in Cart, No access to Cart Page';
  get test_2_products_in_cartPage => 'Acessing Cart Page + Testing two product added';
  get check_amount_cart => 'Checking Amount Cart';
  get order_cart_products_order_now_button => 'Ordering Cart Products - Order Now button';
  get clear_cart_products => 'Clearing Cart Products - ClearCart IconButton';
  get test_page_backbutton => 'Testing Page BackButton';

  // @formatter:on
}
