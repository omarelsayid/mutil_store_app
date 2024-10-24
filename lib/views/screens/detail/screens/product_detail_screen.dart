import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/product.dart';
import '../../../../provider/cart_provider.dart';
import '../../../../services/manage_http_response.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartprovider.notifier);
    final cartData = ref.watch(cartprovider);
    final isInCart = cartData.containsKey(widget.product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.productName,
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 260,
              height: 275,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      top: 50,
                      child: Container(
                        width: 260,
                        height: 260,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          color: Color(0XFFD8DDFF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(130),
                          ),
                        ),
                      )),
                  Positioned(
                    left: 22,
                    top: 0,
                    child: Container(
                      width: 216,
                      height: 274,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: const Color(0xFF9CA8FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: SizedBox(
                        height: 300,
                        child: PageView.builder(
                          itemCount: widget.product.images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.product.images[index],
                              width: 198,
                              height: 225,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.productName,
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: const Color(0xFF3C55Ef),
                  ),
                ),
                Text(
                  '\$${widget.product.productPrice}',
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3C55Ef),
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.product.category,
            style: GoogleFonts.roboto(
              color: Colors.grey,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          Row(
            children: [
              widget.product.totalRatings == 0
                  ? const Text('')
                  : const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.star, color: Colors.amber, size: 18),
                    ),
              Text(widget.product.avrageRating.toString(),
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                "(${widget.product.totalRatings})",
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About',
                  style: GoogleFonts.lato(
                      fontSize: 17,
                      letterSpacing: 1.7,
                      color: const Color(0xFF363330)),
                ),
                SingleChildScrollView(
                  child: Text(
                    widget.product.description,
                    style: GoogleFonts.mochiyPopOne(
                      fontSize: 15,
                      letterSpacing: 2,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8),
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
                    productDescription: widget.product.description,
                    fullName: widget.product.fullName,
                  );

                  showSnackBar(
                    context,
                    widget.product.productName,
                  );
                },
          child: Container(
            width: 386,
            height: 46,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isInCart ? Colors.grey : const Color(0xFF3B54EE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
                child: Text(
              'ADD TO CART',
              style: GoogleFonts.mochiyPopOne(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )),
          ),
        ),
      ),
    );
  }
}
