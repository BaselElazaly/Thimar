class ProductModel {
  late final int id;
  late final String title;
  late final String description;
  late final double priceBeforeDiscount;
  late final double price;
  late final double discount;
  late final String mainImage;
  late final String unitName;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    priceBeforeDiscount = (json['price_before_discount'] ?? 0).toDouble();
    price = (json['price'] ?? 0).toDouble();
    discount = (json['discount'] ?? 0).toDouble();
    mainImage = json['main_image'] ?? "";
    unitName = json['unit']?['name'] ?? "";
  }
}