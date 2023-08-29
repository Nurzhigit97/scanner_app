import 'package:flutter/material.dart';
import 'package:scanner_app/shared/constants/app_constants.dart';
import 'package:scanner_app/shared/widgets/appbar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("HomePage"),
      body: const Center(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(AppConstants.aboutAppText),
      )),
    );
  }
}
