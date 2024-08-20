import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableTextWidget extends StatelessWidget {
  const ReusableTextWidget(
      {super.key, required this.tilte, required this.subTilte});
  final String tilte;
  final String subTilte;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tilte,
            style: GoogleFonts.quicksand(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            subTilte,
            style: GoogleFonts.quicksand(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
