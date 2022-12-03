// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

import '../constant/component.dart';
import '../constant/themes.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  double? width;
  double? height;
  MyButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.width = 130,
    this.height = 45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: prColor,
        ),
        child: Center(
            child: My_Text(
          data: label,
          size: 16,
          color: Colors.white,
        )),
      ),
    );
  }
}
