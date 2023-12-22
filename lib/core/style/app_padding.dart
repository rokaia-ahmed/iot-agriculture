import 'package:flutter/cupertino.dart';
import 'package:iot_agriculture/core/style/app_size.dart';

/// PADDING 5
const EdgeInsets padding5 = EdgeInsets.all(5.0);

/// PADDING 10
const EdgeInsets padding10 = EdgeInsets.all(10.0);

/// PADDING 15
const EdgeInsets padding15 = EdgeInsets.all(15.0);

/// PADDING 20
const EdgeInsets padding20 = EdgeInsets.all(20.0);

class AppPadding {
  static EdgeInsets paddingleft001 = EdgeInsets.only(
    left: AppSize.width * 0.1,
  );

  /// padding horizontal and vertical 007

  static EdgeInsets padding007 = EdgeInsets.symmetric(
    vertical: AppSize.width * 0.07,
    horizontal: AppSize.width * 0.07,
  );

  /// padding horizontal 01
  static EdgeInsets paddingV001 = EdgeInsets.symmetric(
    horizontal: AppSize.width * 0.01,
  );
  static EdgeInsets paddingVV01 = EdgeInsets.symmetric(
    vertical: AppSize.width * 0.01,
  );

  static EdgeInsets padding001 = EdgeInsets.symmetric(
    horizontal: AppSize.width * 0.025,
    vertical: AppSize.width * 0.02,
  );

  static EdgeInsets symmetricPadding60 = EdgeInsets.symmetric(
      horizontal: AppSize.width * 0.06, vertical: AppSize.height * 0.06);
  static EdgeInsets symmetricPadding30 = EdgeInsets.symmetric(
      horizontal: AppSize.width * 0.06, vertical: AppSize.height * 0.03);
  static EdgeInsets symmetricPadding20 = EdgeInsets.symmetric(
      horizontal: AppSize.width * 0.02, vertical: AppSize.height * 0.02);
  static EdgeInsets symmetricPadding10 = EdgeInsets.symmetric(
      vertical: AppSize.height * 0.01, horizontal: AppSize.width * 0.01);
  static EdgeInsets symmetricverticalPadding30 =
      EdgeInsets.symmetric(vertical: AppSize.height * 0.03);
  static EdgeInsets symmetricverticalPadding10 =
      EdgeInsets.symmetric(vertical: AppSize.height * 0.01);
}
