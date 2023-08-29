import 'package:flutter/material.dart';
import 'package:scanner_app/shared/data/models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  void removeAllProducts() {
    _products.clear();
    notifyListeners();
  }
}
