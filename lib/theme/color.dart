import 'package:flutter/material.dart';

import 'mediaquery.dart';

class Pallete {
  static Color textColor = Color((0xFFC4D3E3)); // Color(0xFFC4D3E3);
  static Color color2 = Color(0xFF090B11);
  static Color color3 = Color(0xFF95A1AE);
  static Color color4 = Color(0xFF50575F);
  static Color color5 = Color(0xFF757F8A);
  static Color errorColor = Color(0xFFBD0000);

  static TextStyle textStyle = TextStyle(
      color: Pallete.textColor,
      fontSize: DeviceSize.longestSide * 0.03,
      fontFamily: 'Bold',
      fontWeight: FontWeight.w400);
}
