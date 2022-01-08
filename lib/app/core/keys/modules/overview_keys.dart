import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OverviewKeys {
  final _OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY = "overv_grid_item_favorite_button_key";
  final _OVERVIEW_GRID_ITEM_CART_BTN_KEY = "overv_grid_item_cart_button_key";
  final _OVERVIEW_GRID_PRODUCT_TITLE_KEY = "overv_grid_product_title_key";
  final _OVERVIEW_POPUP_APPBAR_BUTTON_KEY = "overv_popup_filter_fav_all_appbar_btn_key";
  final _OVERVIEW_POPUP_FAVORITE_OPTION_KEY = "overv_favorite_filter_key";
  final _OVERVIEW_POPUP_ALL_OPTION_KEY = "overv_all_filter_key";
  final _OVERVIEW_GRID_ITEM_DETAILS_KEY = "overv_grid_item_details_key";
  final _OVERVIEW_GRID_ITEM_DETAILS_IMAGE_KEY = "overv_item_details_page_image_key";
  final _DRAWWER_SCAFFOLD_GLOBALKEY = GlobalKey<ScaffoldState>();
  final _APPBAR_KEY = "drawer_button_key";
  final _OVERVIEW_PAGE_TITLE_APPBAR_KEY = "overv_page_title_appbar_key";
  final _APPBAR_SLIVER_KEY = "overview_sliver_appbar_key";
  final _OVERVIEW_SLIVER_APPBAR_TITLE_KEY = "overview_sliver_appbar_key";

  String k_ov_sl_appbar() => _APPBAR_SLIVER_KEY;

  String k_ov_sl_tit_appbar() => _OVERVIEW_SLIVER_APPBAR_TITLE_KEY;

  String k_ov_appbar() => _APPBAR_KEY;

  String k_ov_tit_appbar() => _OVERVIEW_PAGE_TITLE_APPBAR_KEY;

  ScaffoldState? k_ov_scfld_glob_state() => _DRAWWER_SCAFFOLD_GLOBALKEY.currentState;

  GlobalKey<ScaffoldState> k_ov_scfld_glob_key() => _DRAWWER_SCAFFOLD_GLOBALKEY;

  String k_ov_grd_fav_btn() => _OVERVIEW_GRID_ITEM_FAVORITE_BUTTON_KEY;

  String k_ov_grd_crt_btn() => _OVERVIEW_GRID_ITEM_CART_BTN_KEY;

  String k_ov_grd_prd_tit() => _OVERVIEW_GRID_PRODUCT_TITLE_KEY;

  String k_ov06() => _OVERVIEW_POPUP_APPBAR_BUTTON_KEY;

  String k_ov_flt_fav() => _OVERVIEW_POPUP_FAVORITE_OPTION_KEY;

  String k_ov_flt_all() => _OVERVIEW_POPUP_ALL_OPTION_KEY;

  String k_ov_itm_det_page() => _OVERVIEW_GRID_ITEM_DETAILS_KEY;

  String k_ov_itm_det_page_img() => _OVERVIEW_GRID_ITEM_DETAILS_IMAGE_KEY;
}