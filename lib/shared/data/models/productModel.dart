class Product {
  final int? id;
  final String barcode;
  final String productName;
  final String createdAt;

  Product({
    this.id,
    required this.barcode,
    required this.productName,
    required this.createdAt,
  });

  Product copyWith({
    int? id,
    String? barcode,
    String? productName,
    String? createdAt,
  }) {
    return Product(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      productName: productName?.trim() ?? this.productName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
