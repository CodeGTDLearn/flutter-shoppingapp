class OrdersTestTitles {
  String REPO_NAME = 'OrdersMockedRepo';

  // @formatter:off
  //GROUP-TITLES ---------------------------------------------------------------
  static get GROUP_TITLE => 'Orders|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  get REPO_TITLE => '$REPO_NAME|Repo: Unit';

  get SERVICE_TITLE => '$REPO_NAME|Service: Unit';

  get CONTROLLER_TITLE => '$REPO_NAME|Controller: Integr';

  get VIEW_TITLE => '$REPO_NAME|View: Functional';

  //TEST-TITLES ----------------------------------------------------------------
  get check_emptyView_noOrderInDb => 'Empty View - No Orders in DB';

  get check_orders_with_one_orderInDB => 'Opening View with One ORDER in DB';

  get test_page_backbutton => 'Testing View BackButton';

  get orderProduct_using_cartView_tapping_orderNowButton =>
      'Ordering from CartView - Taping OrderNow Button';
// @formatter:on
}