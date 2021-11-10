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
class CustomAppbarTestTitles {
  static final String _GROUP_TITLE = 'Components';
  static final String _CUSTOM_APPBAR = 'Custom-Appbar';

  static get GROUP_TITLE => '$_GROUP_TITLE|$_CUSTOM_APPBAR|Functional:';

  get CUSTOM_APPBAR_TITLE => '$_CUSTOM_APPBAR|View: Functional';

  get check_popup_menuitem_enabled_favorites => 'Check Appbar Popup Enabling: favorites';

  get check_popup_menuitem_enabled_all => 'Check Appbar Popup Enabling: All';

  get close_favFilterPopup_tapOutside => 'Closing Favorite_Filter|tap OUTSIDE';

  get close_popup_options => 'check options in PopupMenu';

// get tap_favFilter_noFavoritesFound => 'Tapping FavoriteFilter|Not favorites found';
}