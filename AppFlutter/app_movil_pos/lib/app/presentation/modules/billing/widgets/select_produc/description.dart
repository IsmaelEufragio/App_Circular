import 'package:flutter/material.dart';

class DescriptionProduct extends StatelessWidget {
  const DescriptionProduct({
    super.key,
    required this.text,
    this.fontSize,
    required this.color,
    this.fontWeight,
    this.maxLines = 2,
    this.softWrap,
  });

  final String text;
  final double? fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final bool? softWrap;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: TextOverflow.ellipsis,
    );
  }
}
