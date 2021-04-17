import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:songlyrics/theme/color.dart';
import 'package:songlyrics/theme/mediaquery.dart';

weatherDetailsLoadingFX() {
  return Stack(
    children: [
      Positioned(
        top: DeviceSize.height * 0.12,
        left: DeviceSize.width * 0.05,
        child: CircularProgressIndicator(
          strokeWidth: 10.0,
          backgroundColor: Colors.grey[400],
        ),
      ),
      Positioned(
          top: DeviceSize.height * 0.1,
          right: DeviceSize.width * 0.03,
          child: Shimmer.fromColors(
            highlightColor: Colors.grey[300],
            baseColor: Colors.grey[200],
            period: Duration(seconds: 2),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
            ),
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          countryNameShimmer(),
          SizedBox(height: DeviceSize.height * 0.00),
          weatherDetailsContainerShimmer(),
          windDetails(),
        ],
      ),
    ],
  );
}

Widget windDetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(''),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            highlightColor: Colors.grey[300],
            baseColor: Colors.grey[100],
            child: Container(
              height: DeviceSize.height * 0.04,
              width: DeviceSize.height * 0.1,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(width: DeviceSize.width * 0.025),
          Shimmer.fromColors(
            highlightColor: Colors.grey[300],
            baseColor: Colors.grey[200],
            child: Container(
              height: DeviceSize.height * 0.04,
              width: DeviceSize.height * 0.1,
              color: Colors.red,
            ),
          ),
        ],
      )
    ],
  );
}

countryNameShimmer() {
  return Shimmer.fromColors(
    highlightColor: Colors.grey[300],
    baseColor: Colors.grey[200],
    child: Container(
      height: DeviceSize.height * 0.04,
      width: DeviceSize.height * 0.1,
      color: Colors.red,
    ),
  );
}

Widget weatherDetailsContainerShimmer() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          highlightColor: Colors.grey[300],
          baseColor: Colors.grey[200],
          child: Container(
            height: DeviceSize.height * 0.2,
            width: DeviceSize.height * 0.2,
            color: Colors.red,
          ),
        ),
        SizedBox(height: DeviceSize.height * 0.02),
      ],
    ),
  );
}

Widget searchTextFiled({Function(String) onChanged}) {
  return Container(
    color: Colors.red,
    child: TextField(
      decoration: InputDecoration(fillColor: Pallete.color4),
      onChanged: onChanged,
    ),
  );
}
