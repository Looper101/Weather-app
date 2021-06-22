import 'package:flutter/material.dart';
import 'package:songlyrics/theme/mediaquery.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      color: Theme.of(context).buttonColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DrawerHeader(
              padding: EdgeInsets.only(top: 20),
              child: Text('P-O-I-N-Q'),
            ),
            SizedBox(),
            // ignore: deprecated_member_use
            FlatButton(
              color: Colors.blueGrey[200],
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AboutDialog(
                        applicationName: 'Poinq',
                        applicationVersion: 'version 1.0.0',
                        applicationIcon: Text('To e added soon'),
                      );
                    });
              },
              child: Text('About Developer',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: DeviceSize.longestSide * 0.03,
                      fontWeight: FontWeight.w100)),
            ),
          ],
        ),
      ),
    ),
  );
}
