/* INSTRUCTIONS ABOUT 'REPO-REAL-DE-PRODUCAO' E 'REPO-REAL-DE-PRODUCAO'
  https://timm.preetz.name/articles/http-request-flutter-test
  By DEFAULT, HTTP request made in tests invoked BY flutter test
  result in an empty response (400).
  By DEFAULT, It is a good behavior to avoid external
  dependencies and hence reduce flakyness(FRAGILE) tests.
  THEREFORE:
  A) TESTS CAN NOT DO EXTERNAL-HTTP REQUESTS/CALLS;
  B) HENCE, THE TESTS CAN NOT USE 'REPO-REAL-DE-PRODUCAO'
  C) SO, THE TESTS ONLY WILL USE
     'REPO-REAL-DE-PRODUCAO'MockedRepoClass(no external calls)
   */
class OverviewTestTitles {
  String REPO_NAME = 'OverviewMockedRepo';

  // @formatter:off
  //GROUP-TITLES ---------------------------------------------------------------
  static get GROUP_TITLE => 'OverView|Integration-Tests:';
  static get DETAIL_GROUP_TITLE => 'OverView-Details|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  get REPO_TITLE => '$REPO_NAME|Repo: Unit';
  get SERVICE_TITLE => '$REPO_NAME|Service: Unit';
  get CONTROLLER_TITLE => '$REPO_NAME|Controller: Integr';
  get VIEW_TITLE => '$REPO_NAME|View: Functional';
  get DETAIL_VIEW_TITLE => '$REPO_NAME|View|Details: Functional';

  //OVERVIEW-TEST-TITLES -------------------------------------------------------
  get check_overviewGridItems_in_overviewview => 'Checking products';
  get toggle_productFavoriteButton => 'Toggling FavoritesIconButton in a product';
  get add_identicalProduct2x_Check_ShopCartIcon =>
      'Adding same product 2x + Check: ShopCartIcon|Snackbar';
  get addProduct_click_undoSnackbar_check_shopCartIcon =>
      'Adding product + Clicking Snackbar Undo';
  get add_identicalProduct3x_check_shopCartIcon =>
      'Adding a product 3x + Check ShopCartIcon';
  get add_4differentProducts_check_shopCartIcon =>
      'Adding 4 different products + Check ShopCartIcon';
  get add_prods3And4_check_shopCartIcon => 'Adding products 3/4 + Checking ShopCartIcon';
  get tap_favoritesFilter_noFavoritesFound =>
      'Tapping FavoriteFilter - Not favorites found';
  get tap_favoriteFilterPopup => 'Tapping FavoriteFilter';
  get close_favoriteFilterPopup => 'Closing Favorite_Filter (tap OUTSIDE)';

  //OVERVIEW-DETAILS-TEST-TITLES -----------------------------------------------
  get click_product_check_details_texts => 'Click Product + Check Details View (texts)';
  get click_product_check_details_image => 'Click Product + Check Details View (image)';
  get click_product_details_back_button => 'Testing BackButton';
  // @formatter:on
}
