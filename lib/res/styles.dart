import 'package:flutter/widgets.dart';
import 'package:hg_router/res/index.dart';
import 'package:flutter/material.dart';

class ITextStyles {
  static TextStyle white_font10 = TextStyle(color: Colors.white, fontSize: 10);
  static TextStyle white_font15 = TextStyle(color: Colors.white, fontSize: 15);
  static TextStyle white_font13 = TextStyle(color: Colors.white, fontSize: 13);
  static TextStyle white_font16 = TextStyle(color: Colors.white, fontSize: 16);
  static TextStyle white_font16_Bold =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle pageTitleStyle =
      TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle pageTitleStyleBlack =
      TextStyle(color: Colors.black, fontSize: 17);

  static TextStyle grey_font11 = TextStyle(color: Colors.grey, fontSize: 11);
  static TextStyle pageSubTextStyle =
      TextStyle(color: Colors.grey, fontSize: 12);
  static TextStyle grey_font13 = TextStyle(color: Colors.grey, fontSize: 13);

  static TextStyle black_font10 = TextStyle(color: Colors.black, fontSize: 10);
  static TextStyle black_font12 = TextStyle(color: Colors.black, fontSize: 12);
  static TextStyle pageTextStyle = TextStyle(color: Colors.black, fontSize: 16);
  static TextStyle pageTextStyleWhite =
      TextStyle(color: Colors.white, fontSize: 16);
  static TextStyle pageTextStyleGrey =
      TextStyle(color: Colors.grey, fontSize: 13);
  static TextStyle black_font15 = TextStyle(color: Colors.black, fontSize: 15);
  static TextStyle black_font16 = TextStyle(color: Colors.black, fontSize: 16);

  static TextStyle home_tab =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 13);
  static TextStyle blackBoldFont17 =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black);
  static TextStyle appBarTitleStyle =
      TextStyle(color: Colors.white, fontSize: 17);
  static TextStyle appBarActionTextStyle =
      TextStyle(color: Colors.white, fontSize: 13);
}

class Gaps {
  static Widget hGap5 = new SizedBox(width: Dimens.gap_dp5);
  static Widget hGap10 = new SizedBox(width: Dimens.gap_dp10);
  static Widget hGap20 = new SizedBox(width: Dimens.gap_dp20);
  static Widget hGap25 = new SizedBox(width: Dimens.gap_dp25);
  static Widget hGap30 = new SizedBox(width: Dimens.gap_dp30);
  static Widget hGap50 = new SizedBox(width: Dimens.gap_dp50);
  static Widget vGap15 = new SizedBox(height: Dimens.gap_dp15);
  static Widget vGap20 = new SizedBox(height: Dimens.gap_dp20);
  static Widget vGap50 = new SizedBox(height: Dimens.gap_dp50);
  static Widget vGap100 = new SizedBox(height: Dimens.gap_dp100);
}
