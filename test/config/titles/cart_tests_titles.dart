class CartTestsTitles {
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
  get add_product_check_appbar_shopCart => 'Adding 2 products|Check Appbar CartIcon qtde';
  get check_2products_inCartPage => 'Check  2 products in CartPage';
  get add_product_check_snackbar => 'Adding product|Check Snackbar';
  get denying_dismissingCartItem => 'Denying FIRST product Dismissing';
  get dismissing_first_added_product => 'Dismissing FIRST added product';
  get dismissing_all_added_products => 'Dismissing ALL products';
  get emptyCart_blockAccessCartPage => 'Empty Cart|block Access to Cart Page';
  get open_cartPage_check2Products => 'Opening CartView|Checking 2 products';
  get check_amount_cart => 'Checking Amount Cart';
  get order_cartProducts_tapOrderNowButton => 'Ordering Products|Order Now button';
  get clearCart_tapClearButton => 'Clearing Products|ClearCart IconButton';
  get test_page_backbutton => 'Testing Page BackButton';

  // @formatter:on
}
