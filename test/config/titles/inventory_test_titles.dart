class InventoryTestTitles {
  // @formatter:off
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

  //TEST-TITLES ----------------------------------------------------------------
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
  get edit_add_product_in_form => 'Adding a product';
  get edit_preview_url_in_form => 'Check previewImageUrl';
  get edit_fill_form_with_invalid_content => 'Filling fields testing INValidation';
  // @formatter:on
}
