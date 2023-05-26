import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button_text.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.primary,

    required this.fuc,
    required this.textWidget, // Required TextWidget parameter
  }) : super(key: key);

  final Color primary;

  final Function fuc;
  final TextWidget textWidget; // Add TextWidget parameter to constructor

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      width: MediaQuery.of(context).size.width / 1.35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: primary),
        onPressed: () {
          fuc();
        },
        child: textWidget, // Use the provided TextWidget
      ),
    );
  }
}
