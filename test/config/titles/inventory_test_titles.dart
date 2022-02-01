class InventoryTestTitles {
  //GROUP-TITLES ---------------------------------------------------------------
  static get GROUP_TITLE => 'Inventory|Integration-Tests:';

  static get EDIT_GROUP_TITLE => 'Inventory-Edit|Integration-Tests:';

  static get VALID_GROUP_TITLE => 'Inventory-Validation|Integration-Tests:';

  //MVC-TITLES -----------------------------------------------------------------
  String REPO_NAME = 'InventoryMockedRepo';

  get REPO_TITLE => '$REPO_NAME|Repo: Unit';

  get SERVICE_TITLE => '$REPO_NAME|Service: Unit';

  get CONTROLLER_TITLE => '$REPO_NAME|Controller: Integr';

  get VIEW_TITLE => '$REPO_NAME|View: Functional';

  get VIEW_VALID_TITLE => '$REPO_NAME|View-Edit|Validation: Functional';

  get VIEW_EDIT_TITLE => '$REPO_NAME|View-Edit: Functional';

  // REPO-TITLES ---------------------------------------------------------------
  get repo_get_products => 'Getting Products';

  get repo_get_products_auth_error => 'Getting products - Error authentication';

  get repo_add_product => 'Adding a Product';

  get repo_update_product => 'Updating a Product - status 200';

  get repo_remove_product => 'Deleting a Product - status 200';

  // SERVICE-TITLES ------------------------------------------------------------
  get service_get_products => 'Getting Products';

  get service_add_product => 'Adding Product';

  get service_get_local_products => 'Getting LocalDataManagedProducts';

  get service_add_local_product => 'Adding Product in LocalDataManagedProducts';

  get service_remove_product_transaction => 'Deleting a Product - transaction';

  get service_remove_product_exc => 'Deleting a Product - Not found - Exception';

  get service_clean_local_data => 'Clearing LocalDataManagedProducts';

  get service_get_products_qtde => 'Getting ProductsQtde';

  get service_get_products_by_id => 'Getting ProductById';

  get service_get_products_by_id_exc => 'Getting ProductById - Exception';

  get service_remove_product => 'Deleting a Product';

  get service_update_product => 'Updating a Product';

  // CONTROLLER-TITLES ---------------------------------------------------------
  get controller_GetManagedProductsObs => 'Getting using GetManagedProductsObs';

  get controller_add_product => 'Adding a Product';

  get controller_get_products_qtde => 'Getting ProductsQtde';

  get controller_get_product_by_id => 'Getting ProductById';

  get controller_get_product_by_id_exc => 'Getting ProductById - Exception';

  get controller_update_product => 'Updating a Product - status 200';

  get controller_update_product_status_500 => 'Updating a Product - status 500';

  get controller_update_managed_products_obs => 'Updating ManagedProductsObs';

  get controller_delete_product_status_200 => 'Deleting Product - status 200';

  get controller_delete_transaction => 'Deleting Product - transaction';

  get controller_delete_transaction_exc => 'Deleting a Product - Not found - Exception';

  get controller_reload_view => 'Testing getReloadManagedProductsEditPage';

  // VIEW-TITLES ---------------------------------------------------------------
  get check_emptyView_noProductInDb => 'Checking products (empty DB)';

  get refresh_view => 'Refreshing View';

  get check_products => 'Checking Products';

  get delete_product => 'Deleting a product';

  get update_product => 'Updating a product';

  get tap_viewBackButton => 'Testing BackButton';

  //TEST-TITLES: TITLE CHECK VALIDATIONS + CHECK INJECTIONS --------------------
  get validation_title_size => 'Title|Validation|min 05 chars';

  get validation_title_inject => 'Title|Injection (OWASP)';

  get validation_title_empty => 'Title|Validation|empty not allowed';

  //TEST-TITLES: DESCRIPTION CHECK VALIDATIONS + CHECK INJECTIONS --------------
  get validation_descript_size => 'Description|Validation|min 10 chars';

  get validation_descript_inject => 'Description|Injection (OWASP)';

  get validation_descript_empty => 'Description|Validation|empty not allowed';

  //TEST-TITLES: PRICE CHECK VALIDATIONS + CHECK INJECTIONS --------------------
  get validation_price_size => 'Price|Validation|max 07 chars';

  get validation_price_inject => 'Price|Injection (OWASP)';

  get validation_price_empty => 'Price|Validation|empty not allowed';

  //TEST-TITLES: URL CHECK VALIDATIONS + CHECK INJECTIONS ----------------------
  get validation_url_size => 'Url Image|Validation|max 135 chars';

  get validation_url_inject => 'Url Image|Injection (OWASP)';

  get validation_url_empty => 'Url Image|Validation|empty not allowed';

  //TEST-TITLES: URL CHECK VALIDATIONS + CHECK INJECTIONS ----------------------

  get edit_back_button => 'Testing BackButton';

  get add_product_in_edit_form => 'Adding a product using Edit-Form';

  get test_auto_currency_in_form => 'Check auto currency';

  get edit_preview_url_in_form => 'Check previewImageUrl';

  get edit_fill_form_with_invalid_content => 'Filling fields testing INValidation';

}