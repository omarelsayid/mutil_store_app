import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../controller/product_review_controller.dart';
import '../../../../models/order.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final TextEditingController _reviewController = TextEditingController();
  final ProductReviewController _productReviewController =
      ProductReviewController();
  double ratting =
      3; // the value of it will be threee cause the intila ratting is 3
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.order.productName,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 335,
            height: 153,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 336,
                      height: 154,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(
                            0xFFEFF0F2,
                          ),
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 30,
                            top: 9,
                            child: Container(
                              width: 78,
                              height: 78,
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBCC5FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 10,
                                    top: 5,
                                    child: Image.network(
                                      widget.order.image,
                                      width: 58,
                                      height: 67,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 101,
                            top: 14,
                            child: SizedBox(
                              width: 216,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              widget.order.productName,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              widget.order.category,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF7F808C),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            '\$${widget.order.productPrice.toStringAsFixed(2)}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF0B0C1E),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 13,
                            top: 113,
                            child: Container(
                              width: 100,
                              height: 25,
                              clipBehavior: Clip.none,
                              decoration: BoxDecoration(
                                color: widget.order.delivered
                                    ? const Color(0xFF3C55EF)
                                    : widget.order.processing
                                        ? Colors.purple
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(
                                  4,
                                ),
                              ),
                              child: Stack(
                                clipBehavior: Clip.antiAlias,
                                children: [
                                  Positioned(
                                    left: 9,
                                    top: 2,
                                    child: Text(
                                      widget.order.delivered
                                          ? 'Delivered'
                                          : widget.order.processing
                                              ? "Processing"
                                              : "Cancelled",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        letterSpacing: 1.3,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                              top: 115,
                              left: 298,
                              child: InkWell(
                                onTap: () {},
                                child: Image.asset(
                                  'assets/icons/delete.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              width: 336,
              height: widget.order.delivered ? 170 : 120,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFEFF0F2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery Address',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '${widget.order.state} ${widget.order.city} ${widget.order.locality}',
                          style: GoogleFonts.lato(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'To : ${widget.order.fullName}',
                          style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Order Id: ${widget.order.id}",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  widget.order.delivered
                      ? TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _productReviewController
                                            .uploadReview(
                                                review: _reviewController.text,
                                                productId: widget.order.id,
                                                fullName: widget.order.fullName,
                                                email: widget.order.email,
                                                rating: ratting,
                                                buyerId: widget.order.buyerId,
                                                context: context)
                                            .whenComplete(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: const Text('submit'),
                                    )
                                  ],
                                  title:
                                      const Center(child: Text('Your review')),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        width: double.infinity,
                                      ),
                                      Lottie.asset(
                                          'assets/lottie/Animation - 1728809548427.json',
                                          height: 100),
                                      TextFormField(
                                        controller: _reviewController,
                                        decoration: const InputDecoration(
                                          labelText: 'review',
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RatingBar(
                                        filledIcon: Icons.star,
                                        emptyIcon: Icons.star_border,
                                        onRatingChanged: (value) =>
                                            ratting = value,
                                        initialRating: 3,
                                        maxRating: 5,
                                        halfFilledIcon: Icons.star_half,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            'Leave a Review',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
