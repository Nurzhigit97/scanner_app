// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/shared/data/models/product.dart';
import 'package:scanner_app/shared/data/repos/product_provider.dart';

// ignore: must_be_immutable
class ScanResultPage extends StatefulWidget {
  String barcode;

  ScanResultPage({super.key, required this.barcode});

  @override
  // ignore: library_private_types_in_public_api
  _ScanResultPageState createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
              controller: _nameController,
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
                  _nameController.text = ''; // Clear the name field
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
                    if (_nameController.text.isNotEmpty) {
                      Provider.of<ProductProvider>(context, listen: false)
                          .addProduct(
                        Product(
                            name: _nameController.text,
                            barcode: widget.barcode),
                      );
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
