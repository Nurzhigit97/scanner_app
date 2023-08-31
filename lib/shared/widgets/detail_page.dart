import 'package:flutter/material.dart';
import 'package:scanner_app/shared/widgets/appbar_widget.dart';

class DetailPage extends StatelessWidget {
  final String barcode;
  final String nameProduct;
  final String createdAt;
  const DetailPage(
      {Key? key,
      required this.barcode,
      required this.nameProduct,
      required this.createdAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Detail Page"),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            nameProduct,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            barcode,
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            createdAt,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      )),
    );
  }
}
