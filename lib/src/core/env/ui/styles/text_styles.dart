import 'package:flutter/cupertino.dart';

class TextStyles {
  static TextStyles? _instance;
  // Avoid self isntance
  TextStyles._();
  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get fonFamily => 'mplus1';

  TextStyle get textLight =>
      TextStyle(fontWeight: FontWeight.w300, fontFamily: fonFamily);

  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: fonFamily);

  TextStyle get textMedium =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: fonFamily);

  TextStyle get textSemiBold =>
      TextStyle(fontWeight: FontWeight.w600, fontFamily: fonFamily);

  TextStyle get textBold =>
      TextStyle(fontWeight: FontWeight.bold, fontFamily: fonFamily);

  TextStyle get textExtraBold =>
      TextStyle(fontWeight: FontWeight.w800, fontFamily: fonFamily);

  TextStyle get textButtonLabel => textBold.copyWith(fontSize: 14);
  TextStyle get textTitle => textExtraBold.copyWith(fontSize: 22);
}

extension TextStylesExtenseions on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
