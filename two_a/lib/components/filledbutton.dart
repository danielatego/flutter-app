import 'package:flutter/material.dart';

class CustomFilledButton extends ButtonStyle {
  final String name;
  final BuildContext context;

  @override
  AlignmentGeometry? get alignment => Alignment.center;
  @override
  // TODO: implement shape
  MaterialStateProperty<OutlinedBorder?>? get shape => (
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8 * wf)),
        fixedSize: Size(240 * wf, 40 * sf)
      );

  const CustomFilledButton({
    required this.name,
    required this.context,
  });
}
