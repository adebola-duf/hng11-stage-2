import 'dart:ui';

class Shoe {
  Shoe({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.discountedPrice,
    required this.description,
    required this.needsRotation,
    required this.bgColor,
    required this.availableQty,
  });
  final String imageUrl;
  final String name;
  final double price;
  final double? discountedPrice;
  final String description;
  final bool needsRotation;
  final Color bgColor;
  final int availableQty;

  String get priceInString {
    RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return '₦${price.toString().replaceAllMapped(regExp, (match) => '${match[1]},')}';
  }

  String get discountedPriceInString => '₦$discountedPrice';

  String get discountPercentage =>
      '-${(((price - (discountedPrice ?? 0)) / price) * 100).toStringAsFixed(0)}% ';

  @override
  String toString() {
    return 'Shoe(imageUrl: $imageUrl, name: $name, price: $price, discountedPrice: $discountedPrice, description: $description, needsRotation: $needsRotation)';
  }
}
