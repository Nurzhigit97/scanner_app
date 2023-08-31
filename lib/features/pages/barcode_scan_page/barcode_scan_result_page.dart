import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/shared/data/models/productModel.dart';
import 'package:scanner_app/features/cubits/product_cubit.dart';

// ignore: must_be_immutable
class ScanResultPage extends StatefulWidget {
  String barcode;

  ScanResultPage({super.key, required this.barcode});

  @override
  // ignore: library_private_types_in_public_api
  _ScanResultPageState createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  late TextEditingController _productNameController;

  @override
  void initState() {
    super.initState();
    _productNameController = TextEditingController();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _productNameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: 'Barcode', suffixIcon: Icon(Icons.edit)),
              controller: TextEditingController(text: widget.barcode),
              onTap: () async {
                String updatedBarcode = await FlutterBarcodeScanner.scanBarcode(
                    '#FF0000', 'Cancel', true, ScanMode.BARCODE);

                if (updatedBarcode.isNotEmpty) {
                  _productNameController.text = ''; // Clear the name field
                  setState(() {
                    widget.barcode = updatedBarcode;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_productNameController.text.isNotEmpty) {
                      context.read<ProductCubit>().addProduct(Product(
                            barcode: widget.barcode,
                            productName: _productNameController.text,
                            createdAt: DateTime.now().toString(),
                          ));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
