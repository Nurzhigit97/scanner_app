import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_app/features/cubits/product_cubit.dart';
import 'package:scanner_app/features/cubits/product_state.dart';
import 'package:scanner_app/shared/extenstions/on_context.dart';
import 'package:scanner_app/shared/widgets/app_error_text.dart';
import 'package:scanner_app/shared/widgets/appbar_widget.dart';
import 'package:scanner_app/shared/widgets/detail_page.dart';
import 'package:scanner_app/shared/widgets/progress_indicator_widget.dart';

class HistoryScanPage extends StatelessWidget {
  const HistoryScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();

    return Scaffold(
      appBar: appBarWidget("History Page"),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductError) AppErrorText(message: state.message);

          if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  title: Text(product.productName),
                  subtitle: Text(product.barcode),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async =>
                        await productCubit.deleteProduct(product.id ?? 2),
                  ),
                  onTap: () {
                    context.push(DetailPage(
                      barcode: product.barcode,
                      nameProduct: product.productName,
                      createdAt: product.createdAt,
                    ));
                  },
                );
              },
            );
          }
          return const ProgressIndicatorWidget();
        },
      ),
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
        onPressed: () {
          productCubit.deleteProductAllProduct();
        },
        label: const Text("Remove all"),
        icon: const Icon(Icons.delete_forever),
      ),
    );
  }
}
