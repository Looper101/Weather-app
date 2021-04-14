import 'package:flutter/material.dart';

class DeviceSize {
  static double height;
  static double width;

  static double longestSide;
  MediaQueryData mq;

  init(BuildContext context) {
    mq = MediaQuery.of(context);

    height = mq.size.height;
    width = mq.size.width;
    longestSide = mq.size.longestSide;
  }
}
