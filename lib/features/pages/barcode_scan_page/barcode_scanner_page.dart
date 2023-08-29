import 'package:flutter/material.dart';
import 'package:scanner_app/features/pages/barcode_scan_page/barcode_scan_result_page.dart';
import 'package:scanner_app/shared/widgets/appbar_widget.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("Scanner Page"),
      body: Center(
        child: IconButton(
          onPressed: () async {
            String barcode = await FlutterBarcodeScanner.scanBarcode(
                '#FF0000', 'Cancel', true, ScanMode.BARCODE);

            if (barcode.isNotEmpty) {
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScanResultPage(barcode: barcode),
                ),
              );
            }
          },
          icon: const Icon(
            Icons.qr_code_scanner_outlined,
            size: 40,
          ),
        ),
      ),
    );
  }
}
