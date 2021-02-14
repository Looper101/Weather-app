import 'package:flutter/cupertino.dart';

class DeviceOrientation {
  static double screenHeight;
  static double screenWidth;

  static double longestSide;
  MediaQueryData mq;

  init(BuildContext context) {
    mq = MediaQuery.of(context);

    screenHeight = mq.size.height;
    screenWidth = mq.size.width;
    longestSide = mq.size.longestSide;
  }
}
