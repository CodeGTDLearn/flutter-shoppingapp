class OrdersTestTitles {
  String REPO_NAME = 'OrdersMockedRepo';

  //GROUP-TITLES ---------------------------------------------------------------
  static get GROUP_TITLE => 'Orders|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  get REPO_TITLE => '$REPO_NAME|Repo: Unit';

  get SERVICE_TITLE => '$REPO_NAME|Service: Unit';

  get CONTROLLER_TITLE => '$REPO_NAME|Controller: Integr';

  get VIEW_TITLE => '$REPO_NAME|View: Functional';

  // VIEW-TITLES ---------------------------------------------------------------
  get check_emptyView_noOrderInDb => 'Empty View - No Orders in DB';

  get check_orders_with_one_orderInDB => 'Opening View with One ORDER in DB';

  get test_page_backbutton => 'Testing View BackButton';

  get orderProduct_using_cartView_tap_orderNowButton =>
      'Ordering from CartView - Taping OrderNow Button';

  // REPO-TITLES ---------------------------------------------------------------
  get repo_get_orders => 'Getting Orders';

  get repo_add_order => 'Adding Order';

  // SERVICE-TITLES ------------------------------------------------------------
  get service_get_orders => 'Getting Orders';

  get service_get_local_orders => 'Getting Orders (getLocalDataOrders)';

  get service_get_orfers_qtde => 'Getting the Orders Quantity';

  get service_clean_orders => 'Clearing Orders';

  // CONTROLLER-TITLES ---------------------------------------------------------
  Object get controller_get_orders => 'Getting Orders';

  Object get controller_clear_orders => 'Clearing Orders';
}