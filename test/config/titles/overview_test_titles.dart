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

  // @formatter:off
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

  get add_sameProduct3x_check_shopCartIcon =>
      'Adding same product 3x|Check ShopCartIcon';

  get add_allProducts_check_shopCartIcon =>
      'Adding All products|Check ShopCartIcon';

  get add_prods3And4_check_shopCartIcon =>
      'Adding Last 2 products|Checking ShopCartIcon';

  // get tap_favFilterPopup => 'Tapping FavoriteFilter';

  // get tap_favFilter_noFavoritesFound =>
  //     'Tapping FavoriteFilter|Not favorites found';

  get toggle_favoriteButton_in_product =>
      'Toggling FavoritesIconButton in a product';

  //OVERVIEW-DETAILS-TEST-TITLES -----------------------------------------------
  get tap_product_details_check_texts =>
      'Tap Product|Check Details(texts)|Backbutton';

  get tap_product_details_check_image =>
      'Tap Product|Check Details(image)|Backbutton';

  get tap_product_details_click_back_button =>
      'Testing Details-View BackButton';
// @formatter:on
}