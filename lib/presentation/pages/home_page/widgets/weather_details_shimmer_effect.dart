import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:songlyrics/theme/mediaquery.dart';

weatherDetailsLoadingFX() {
  return Container(
    height: double.infinity,
    width: double.infinity,
    child: Stack(
      children: [
        Positioned(
          top: DeviceSize.height * 0.12,
          left: DeviceSize.width * 0.05,
          child: CircularProgressIndicator(
            strokeWidth: 10.0,
            backgroundColor: Colors.grey[400],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: DeviceSize.height * 0.00),
          ],
        ),
      ],
    ),
  );
}
