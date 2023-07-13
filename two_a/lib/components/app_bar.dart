import 'package:flutter/material.dart';
import 'package:two_a/extensions/buildcontext/loc.dart';

class CustomAppbar extends AppBar {
  final BuildContext context;
  final String locTitle;
  final toolHeight = 36.0;

  @override
  Widget? get title => Text(
        locTitle,
        style: Theme.of(context).textTheme.titleMedium,
        textScaleFactor: context.scaleFactor[1],
      );

  @override
  Size get preferredSize =>
      Size.fromHeight(toolHeight * context.scaleFactor[0]);

  CustomAppbar({
    super.key,
    required this.context,
    required this.locTitle,
  });
}
