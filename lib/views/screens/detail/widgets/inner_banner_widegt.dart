import 'package:flutter/material.dart';

class InnerBannerWidegt extends StatelessWidget {
  const InnerBannerWidegt({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 178,
        width: MediaQuery.sizeOf(context).width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
