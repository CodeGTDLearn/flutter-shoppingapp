/* INSTRUCTIONS ABOUT 'REPO-REAL-DE-PRODUCAO'
  https://timm.preetz.name/articles/http-request-flutter-test
  By DEFAULT, HTTP request made in tests invoked BY flutter test
  result in an empty response (400).
  By DEFAULT, It is a good behavior to avoid external
  dependencies and hence reduce flakyness(FRAGILE) tests.
  THEREFORE:
  A) TESTS CAN NOT DO EXTERNAL-HTTP REQUESTS/CALLS;
  B) HENCE, THE TESTS CAN NOT USE 'REPO-REAL-DE-PRODUCAO'(no external calls)
  C) SO, THE TESTS ONLY WILL USE MockedRepoClass/MockedDatasource
   */
class OverviewTestTitles {
  String REPO_NAME = 'OverviewMockedRepo';

  //GROUP-TITLES ---------------------------------------------------------------
  static get GROUP_TITLE => 'OverView|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  get REPO_TITLE => '$REPO_NAME|Repo: Unit';

  get SERVICE_TITLE => '$REPO_NAME|Service: Unit';

  get CONTROLLER_TITLE => '$REPO_NAME|Controller: Integr';

  get VIEW_TITLE => '$REPO_NAME|View: Functional';

  //OVERVIEW-TEST-TITLES -------------------------------------------------------
  get check_overviewGridItems_qtde => 'Checking products';

  get add_sameProduct2x_check_shopCartIcon =>
      'Adding same product 2x|Check ShopCartIcon+Snackbar';

  get add_product_click_undoSnackbar_check_shopCartIcon =>
      'Adding product|Clicking SnackbarUndo (rollback)';

  get add_sameProduct3x_check_shopCartIcon => 'Adding same product 3x|Check ShopCartIcon';

  get add_allProducts_check_shopCartIcon => 'Adding All products|Check ShopCartIcon';

  get add_prods3And4_check_shopCartIcon => 'Adding Last 2 products|Checking ShopCartIcon';

  get toggle_favoriteButton_in_overviewGridItem =>
      'Toggling FavoritesIconButton in a product(OverviewGridItem)';

  //OVERVIEW-DETAILS-TEST-TITLES -----------------------------------------------
  get tap_product_details_check_texts => 'Tap Product|Check Details(texts)|Backbutton';

  get tap_product_details_check_image => 'Tap Product|Check Details(image)|Backbutton';

  get tap_product_details_click_back_button => 'Testing Details-View BackButton';

  // REPO-TITLES ---------------------------------------------------------------
  get repo_get_qtde_products => 'Getting the quantity of products';

  get repo_get_products => 'Getting products';

  get repo_update_product => 'Updating a Product - Response Status 200';

  // SERVICE-TITLES ------------------------------------------------------------
  get service_get_localdata => 'Checking localDataAllProducts loading';

  get service_get_localdata_favs => 'Checking localDataFavoritesProducts loading';

  get service_add_product_localdata => 'Adding Product in LocalDataAllProducts';

  get service_delete_product_localdata => 'Deleting Product';

  get service_get_products => 'Getting products';

  get service_get_product_exc => 'Getting a product (unknown ID) - Exception';

  get service_toggle_fav_status => 'Toggle FavoriteStatus in one product';

  get service_get_qtde_favs => 'Getting the quantity of favorites';

  get service_get_product_byid => 'Getting a product using its ID';

  get service_get_products_qtde => 'Getting the quantity of products';

  get service_get_products_by_filter => 'Getting products by Filters';

  get service_clear_products_localdata => 'Clearing DataSavingLists';

  // CONTROLLER-TITLES ---------------------------------------------------------
  get controller_get_products => 'Getting products';

  get controller_update_filt_products => 'Updating FilteredProductsObs';

  get controller_delete_produts => 'Deleting Product';

  get controller_get_produts_qtde_favs => 'Getting the quantity of favorites';

  get controller_get_produts_qtde => 'Getting the quantity of products';

  get controller_get_produt_byid => 'Getting a product using its ID';

  get controller_get_produts_by_filters => 'Getting products by Filters';

  get controller_get_toggle_favs => 'Toggle FavoriteStatus in one product';
}