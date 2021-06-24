import 'package:flutter/material.dart';

import '../../search_page/search_page.dart';

Widget buildAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size(0.0, 56.0),
    child: AppBar(
      backgroundColor: Colors.grey[500],
      title: Text(
        'Poinq',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.white70),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, SearchPage.id);
          },
        )
      ],
    ),
  );
}
