import 'package:flutter/material.dart';
import '../theme/mediaquery.dart';

Container developerDetails() {
  return Container(
    height: DeviceSize.height * 0.35,
    width: DeviceSize.width * 0.8,
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text('Lawal Opeyemi Noah'),
                  Text('Mobile App Developer'),
                  Row(
                    children: [
                      Text('Twitter link:'),
                      Text('Https://twitter.com/devlonoah')
                    ],
                  ),
                  //TODO: Add the url launcher for email and twitter
                  Row(
                    children: [Text('Email me:'), Text('devlonoah@gmail.com')],
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('Links'),
              Container(
                height: 3,
                width: double.infinity,
                color: Colors.black45,
              )
            ],
          )
        ],
      ),
    ),
  );
}
