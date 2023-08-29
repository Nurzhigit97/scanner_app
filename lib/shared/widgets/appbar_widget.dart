import 'package:flutter/material.dart';

AppBar appBarWidget(String? title) {
  return AppBar(
    backgroundColor: Colors.blueGrey,
    centerTitle: true,
    title: Text(
      title ?? '',
    ),
  );
}
