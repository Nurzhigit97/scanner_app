import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_app/shared/data/cash/sql_service.dart';
import 'package:scanner_app/shared/data/models/productModel.dart';
import 'package:scanner_app/features/cubits/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> loadProducts() async {
    final productsData = await DatabaseHelper.query('products');
    final products = productsData
        .map((data) => Product(
            barcode: data['barcode'],
            productName: data['productName'],
            createdAt: data['createdAt']))
        .toList();
    emit(ProductLoaded(products));
  }

  Future<void> addProduct(Product product) async {
    await DatabaseHelper.insert('products', {
      'id': product.id,
      'barcode': product.barcode,
      'productName': product.productName,
      'createdAt': product.createdAt,
    });
    await loadProducts();
  }

  Future<void> deleteProduct(int id) async {
    await DatabaseHelper.delete('products', id);
    await loadProducts();
  }

  Future<void> deleteProductAllProduct() async {
    await DatabaseHelper.deleteAll('products');
    await loadProducts();
  }
}
