import 'package:flutter/material.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/models/shoe.dart';

class ShoeCard extends StatelessWidget {
  const ShoeCard({
    super.key,
    required this.shoe,
  });

  final Shoe shoe;
  @override
  Widget build(BuildContext context) {
    const shoeOverFlowHeight = 30.0;
    return SizedBox(
      width: shoeCardWidth,
      height: shoeCardHeight,
      child: Opacity(
        opacity: shoe.availableQty == 0 ? .5 : 1,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: shoeCardHeight - shoeOverFlowHeight,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 30, left: 5, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: shoe.bgColor,
              ),
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shoe.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          if (shoe.discountedPrice != null)
                            RichText(
                              text: TextSpan(
                                text: shoe.discountedPriceInString[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: shoe.discountedPriceInString
                                        .substring(1),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (shoe.discountedPrice == null)
                            RichText(
                              text: TextSpan(
                                text: shoe.priceInString[0],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: shoe.priceInString.substring(1),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const Spacer(),
                          if (shoe.discountedPrice != null)
                            RichText(
                              text: TextSpan(
                                text: shoe.priceInString[0],
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 208, 10, 10),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: shoe.priceInString.substring(1),
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 208, 10, 10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        '${shoe.availableQty} item${shoe.availableQty > 1 ? 's' : ''} left',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -shoeOverFlowHeight,
              child: Hero(
                tag: shoe.name,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: shoe.needsRotation
                      ? Transform(
                          alignment: FractionalOffset.center,
                          transform: Matrix4.rotationZ(
                            -3.1415926535897932 / 4,
                          ),
                          child: Image.network(shoe.imageUrl),
                        )
                      : Image.network(shoe.imageUrl),
                ),
              ),
            ),
            if (shoe.discountedPrice != null)
              Positioned(
                top: 15,
                left: 15,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    shoe.discountPercentage,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
