import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../provider/favourite_provider.dart';
import '../../../../services/manage_http_response.dart';
import '../../../../models/product.dart';
import '../../detail/screens/product_detail_screen.dart';

class ProductItemWidget extends ConsumerStatefulWidget {
  const ProductItemWidget({super.key, required this.product});
  final Product product;

  @override
  ConsumerState<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends ConsumerState<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartprovider);
    final favouriteData = ref.watch(favouriteProvider);
    final favouriteprovider = ref.read(favouriteProvider.notifier);

    final isInCart = cartData.containsKey(widget.product.id);

    final cartProviderData = ref.read(cartprovider.notifier);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetailScreen(product: widget.product);
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
                    widget.product.images[0],
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 140,
                    top: 15,
                    child: InkWell(
                      onTap: () {
                        if (favouriteData.containsKey(widget.product.id)) {
                          favouriteprovider.removeFavourite(widget.product.id);
                        } else {
                          favouriteprovider.addFavourite(
                            quantity: 1,
                            productName: widget.product.productName,
                            category: widget.product.category,
                            image: widget.product.images,
                            vendorId: widget.product.vendorId,
                            productPrice: widget.product.productPrice,
                            productQuantity: widget.product.quantity,
                            productId: widget.product.id,
                            productDescription: widget.product.description,
                            fullName: widget.product.fullName,
                          );
                        }
                      },
                      child: favouriteData.containsKey(widget.product.id)
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            )
                          : Image.asset(
                              'assets/icons/love.png',
                              width: 30,
                              height: 30,
                            ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: isInCart
                            ? null
                            : () {
                                cartProviderData.addProductToCart(
                                  productName: widget.product.productName,
                                  productPrice: widget.product.productPrice,
                                  category: widget.product.category,
                                  image: widget.product.images,
                                  vendorId: widget.product.vendorId,
                                  productQuantity: widget.product.quantity,
                                  quantity: 1,
                                  productId: widget.product.id,
                                  productDescription:
                                      widget.product.description,
                                  fullName: widget.product.fullName,
                                );

                                showSnackBar(
                                  context,
                                  '${widget.product.productName}added to cart',
                                );
                              },
                        child: Image.asset(
                          'assets/icons/cart.png',
                          height: 35,
                          width: 35,
                        ),
                      ))
                ],
              ),
            ),
            Text(
              overflow: TextOverflow.ellipsis,
              widget.product.productName,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: Colors.black,
              ),
            ),
            widget.product.avrageRating == 0
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
                        widget.product.avrageRating.toStringAsFixed(1),
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
            Text(
              widget.product.category,
              style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff868D94)),
            ),
            Text(
              '\$${widget.product.productPrice.toStringAsFixed(2)}',
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
