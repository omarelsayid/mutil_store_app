import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/product.dart';
import '../../detail/screens/product_detail_screen.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetailScreen(product: product);
          },
        ));
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Image.network(
                    product.images[0],
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 140,
                    top: 15,
                    child: Image.asset(
                      'assets/icons/love.png',
                      width: 26,
                      height: 26,
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/icons/cart.png',
                        height: 26,
                        width: 26,
                      ))
                ],
              ),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              product.productName,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Colors.black,
              ),
            ),
            product.avrageRating == 0
                ? const SizedBox()
                : Row(
                    children: [
                      const Icon(
                        Icons.star_sharp,
                        color: Colors.amber,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        product.avrageRating.toStringAsFixed(1),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
            Text(
              product.category,
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff868D94)),
            ),
            Text(
              '\$${product.productPrice.toStringAsFixed(2)}',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            )
          ],
        ),
      ),
    );
  }
}
