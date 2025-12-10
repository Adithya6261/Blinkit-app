import '../models/product_model.dart';

class ProductsData {
  // Single image URL for all products to reduce shader compilation
  static const String defaultImageUrl = 'https://picsum.photos/seed/product/400/400';

  static List<ProductModel> productsForCategory(int categoryIndex) {
    final base = categoryIndex * 10;
    return List.generate(12, (index) {
      final id = base + index + 1;
      return ProductModel(
        id: id.toString(),
        title: 'Product $id',
        price: (20 + id * 2).toString(),
        imageUrl: defaultImageUrl,
        unit: '250g',
        category: 'Category ${categoryIndex + 1}',
        rating: 4.5,
        ratingCount: 100,
        mrp: (30 + id * 2).toString(),
        offerText: '₹50 off above ₹499',
      );
    });
  }
}
