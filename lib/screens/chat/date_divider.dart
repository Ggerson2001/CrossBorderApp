import 'dart:ui';

import 'package:flutter/material.dart';

class DateDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Monday, 10:40 am",
          style: TextStyle(
            fontSize: 15,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
