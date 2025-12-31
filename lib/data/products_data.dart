import 'package:blinkit/resources/app_images.dart';

import '../models/product_model.dart';

class ProductsData {
  static List<Map<String, String>> groceryItems = [
    {
      "title": "Vegetables",
      "image": AppImages.vegetable,
      "unit": "500g",
    },
    {
      "title": "Fruits",
      "image": AppImages.fruit,
      "unit": "1kg",
    },
    {
      "title": "Cakes",
      "image": AppImages.cake,
      "unit": "1 pc",
    },
    {
      "title": "Plants",
      "image": AppImages.plant,
      "unit": "1 pc",
    },
  ];

  static List<ProductModel> productsForCategory(int categoryIndex) {
    final base = categoryIndex * 10;

    return List.generate(12, (index) {
      final id = base + index + 1;
      final item = groceryItems[index % groceryItems.length];

      return ProductModel(
        id: id.toString(),
        title: item["title"]!,
        price: (20 + id * 2).toString(),
        imageUrl: item["image"]!,
        unit: item["unit"]!,
        category: item["title"]!,
        rating: 4.5,
        ratingCount: 100,
        mrp: (30 + id * 2).toString(),
        offerText: '₹50 off above ₹499',
      );
    });
  }
}
