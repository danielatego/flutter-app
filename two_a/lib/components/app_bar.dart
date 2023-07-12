import 'package:flutter/material.dart';
import 'package:two_a/components/mediaquery.dart';

class CustomAppbar extends AppBar {
  final BuildContext context;
  final String locTitle;
  final toolHeight = 36.0;

  @override
  Widget? get title => Text(
        locTitle,
        style: Theme.of(context).textTheme.titleMedium,
        textScaleFactor: wf(),
      );

  @override
  double? get toolbarHeight => (toolHeight * 45);

  double sf() {
    var media = MQuery(context: context);
    return media.heightscalefactor();
  }

  double wf() {
    var media = MQuery(context: context);
    return media.widthScalefactor();
  }

  CustomAppbar({
    super.key,
    required this.context,
    required this.locTitle,
  });
}
