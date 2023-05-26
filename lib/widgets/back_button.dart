import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {

  const CustomBackButton({super.key,
    required this.size,
    required this.color
  });
  final Size size;
  final Color color;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () => Navigator.of(context).pop(),
       child: Icon(Icons.arrow_back_ios_new_rounded,

         color: color,
       ),
      //onPressed: () => Navigator.of(context).pop(),
    );
  }
}
