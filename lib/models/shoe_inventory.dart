import 'dart:convert';
import 'dart:math';

import 'package:myapp/constants.dart';
import 'package:myapp/models/shoe.dart';

class ShoeInventory {
  final List<Shoe> shoeInventory;

  ShoeInventory({required this.shoeInventory});

  factory ShoeInventory.fromJson(Map<String, dynamic> timbuProductsJson) {
    final products = timbuProductsJson['items'];
    final shoes = <Shoe>[];

    final shuffledShoeBgColors = List.from(kShoeBgColors);
    shuffledShoeBgColors.shuffle(Random());
    int index = 0;
    for (final shoeJson in products) {
      final name = shoeJson['name'];
      final myCustomJson = jsonDecode(
          (shoeJson['description'] as String).replaceAll("\\'", '\''));
      final description = myCustomJson['desc'];
      final needsRotation = myCustomJson['needs_rotation'];
      final imageUrl =
          'http://api.timbu.cloud/images/${shoeJson['photos'][0]['url']}';

      final price = shoeJson['current_price'][0]['NGN'][0];
      final discountedPrice = shoeJson['current_price'][0]['NGN'][1];
      final availableQty = shoeJson['available_quantity'];

      shoes.add(
        Shoe(
          availableQty: (availableQty as double).toInt(),
          imageUrl: imageUrl,
          name: name,
          price: price,
          discountedPrice: discountedPrice,
          description: description,
          needsRotation: needsRotation,
          bgColor: shuffledShoeBgColors[index++],
        ),
      );
    }

    return ShoeInventory(shoeInventory: shoes);
  }
}
