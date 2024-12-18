import 'package:flutter/material.dart';

import 'app_colors.dart';

class HeadingTwo extends StatelessWidget {
  final String data;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final Color? backGroundColor;
  const HeadingTwo({
    super.key,
    required this.data,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.sizeOf(context).height;

    return Text(
      data,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color ?? AppColors.textColor,
        fontSize: fontSize ?? sizeHeight * .024,
        fontWeight: fontWeight ?? FontWeight.w500,
        backgroundColor: backGroundColor,
        // fontFamily: 'Lora',
      ),
    );
  }
}

class HeadingThree extends StatelessWidget {
  final String data;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final Color? backGroundColor;
  const HeadingThree({
    super.key,
    required this.data,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.sizeOf(context).height;
    return Text(
      data,
      style: TextStyle(
        color: color ?? AppColors.textColor,
        fontSize: fontSize ?? sizeHeight * 0.02,
        fontWeight: fontWeight ?? FontWeight.w400,
        backgroundColor: backGroundColor,
      ),
    );
  }
}
