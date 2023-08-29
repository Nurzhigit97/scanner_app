import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/features/pages/widgets/detail_page.dart';
import 'package:scanner_app/shared/data/repos/product_provider.dart';
import 'package:scanner_app/shared/widgets/appbar_widget.dart';

class HistoryScanPage extends StatelessWidget {
  const HistoryScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;

    return Scaffold(
      appBar: appBarWidget("History Page"),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.barcode),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<ProductProvider>(context, listen: false)
                    .removeProduct(product);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    barcode: product.barcode,
                    nameProduct: product.name,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
        onPressed: () {
          Provider.of<ProductProvider>(context, listen: false)
              .removeAllProducts();
        },
        label: const Text("Remove all"),
        icon: const Icon(Icons.delete_forever),
      ),
    );
  }
}
