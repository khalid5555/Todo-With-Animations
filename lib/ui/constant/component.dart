// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class My_Text extends StatelessWidget {
  final String data;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final int? maxline;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  const My_Text({
    Key? key,
    required this.data,
    this.color,
    this.size = 18,
    this.fontWeight = FontWeight.bold,
    this.fontFamily = 'Molhim',
    this.maxline,
    this.decoration,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxline,
      data,
      style: TextStyle(
        decoration: decoration,
        overflow: overflow,
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      ),
    );
  }
}
