import 'package:flutter/material.dart';


class TextWidget extends StatelessWidget {
  TextWidget({
    Key? key,
    required this.text,
    required this.color,
    required this.textSize,
    this.isTitle = false,
    this.maxLine = 1,
  }) : super(key: key);

  final String text;
  final Color color;
  final double textSize;
  final bool isTitle;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      style:
        // Use GoogleFonts class to set font family
      TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color,
          fontSize: textSize,
          fontWeight: isTitle ? FontWeight.w600 : FontWeight.normal,
        ),

    );
  }
}
