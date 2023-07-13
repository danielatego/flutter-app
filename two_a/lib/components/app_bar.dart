import 'package:flutter/material.dart';

class CustomAppbar extends AppBar {
  final BuildContext context;
  final String locTitle;
  final toolHeight = 36.0;
  final List scaleFactor;

  @override
  Widget? get title => Text(
        locTitle,
        style: Theme.of(context).textTheme.titleMedium,
        textScaleFactor: scaleFactor[2],
      );

  @override
  Size get preferredSize => Size.fromHeight(toolHeight * scaleFactor[0]);

  CustomAppbar(
      {super.key,
      required this.context,
      required this.locTitle,
      required this.scaleFactor});
}
