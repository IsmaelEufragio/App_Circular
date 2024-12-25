import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    this.textInputAction,
    this.suffixIcon,
    this.bottom = 0,
  });

  final String hintText;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final double bottom;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: AppColors.primary,
        ),
        color: AppColors.info,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextField(
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.aBeeZee(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
          contentPadding: EdgeInsets.only(
            left: 5.0,
            bottom: bottom,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
