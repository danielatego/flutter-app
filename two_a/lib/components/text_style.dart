import 'package:flutter/material.dart';
import 'package:two_a/extensions/buildcontext/loc.dart';

enum Fontweight { w100, w200, w400, w500 }

enum FontColour { black, hintblack, buttonblack }

class CustomTextStyle extends TextStyle {
  final BuildContext context;
  final double fontSz;
  final Fontweight fontWght;
  final FontColour colour;

  @override
  FontWeight get fontWeight => fweight();

  FontWeight fweight() {
    switch (fontWght) {
      case Fontweight.w100:
        return FontWeight.w100;
      case Fontweight.w200:
        return FontWeight.w200;
      case Fontweight.w500:
        return FontWeight.w500;
      default:
        return FontWeight.w400;
    }
  }

  @override
  Color? get color => fontcolour();

  Color fontcolour() {
    switch (colour) {
      case FontColour.black:
        return const Color(0XFF000000);
      case FontColour.buttonblack:
        return const Color(0XFF838383);
      case FontColour.hintblack:
        return const Color(0XFF808080);

      default:
        return const Color(0XFF000000);
    }
  }

  @override
  double? get fontSize => fontSz * context.scaleFactor[1];

  const CustomTextStyle({
    required this.context,
    required this.fontSz,
    required this.fontWght,
    required this.colour,
  });
}
