// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVG extends StatelessWidget {
  const SVG(
      {super.key,
      required this.path,
      required this.width,
      required this.height,
      required this.color});

  final String path;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return color == Colors.transparent
        ? SvgPicture.asset(path,
            height: height, width: width, matchTextDirection: true)
        : SvgPicture.asset(path,
            height: height,
            width: width,
            color: color,
            matchTextDirection: true);
  }
}
