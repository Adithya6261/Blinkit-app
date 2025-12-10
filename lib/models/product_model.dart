class ProductModel {
  final String id;
  final String title;
  final String price;
  final String? mrp;
  final String imageUrl;
  final String unit;
  final String? category; 
  final double? rating; 
  final int? ratingCount; 
  final String? offerText; 
  final String? deliveryTime; 

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    this.mrp,
    required this.imageUrl,
    this.unit = '',
    this.category,
    this.rating,
    this.ratingCount,
    this.offerText,
    this.deliveryTime,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: json['price'] ?? '',
      mrp: json['mrp'],
      imageUrl: json['imageUrl'] ?? '',
      unit: json['unit'] ?? '',
      category: json['category'],
      rating: (json['rating'] != null) ? double.tryParse(json['rating'].toString()) : null,
      ratingCount: (json['ratingCount'] != null) ? int.tryParse(json['ratingCount'].toString()) : null,
      offerText: json['offerText'],
      deliveryTime: json['deliveryTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "mrp": mrp,
        "imageUrl": imageUrl,
        "unit": unit,
        "category": category,
        "rating": rating,
        "ratingCount": ratingCount,
        "offerText": offerText,
        "deliveryTime": deliveryTime,
      };
}
