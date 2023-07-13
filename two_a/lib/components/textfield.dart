import 'package:flutter/material.dart';
import 'package:two_a/components/text_style.dart';

enum Controllr { email, password }

class CustormTextField extends TextField {
  final TextEditingController controllerr;
  final BuildContext context;
  final bool isEmail;

  @override
  TextEditingController? get controller => controllerr;
  @override
  bool get obscureText => isEmail ? true : false;
  @override
  bool get enableSuggestions => false;
  @override
  TextInputType get keyboardType =>
      (isEmail ? TextInputType.emailAddress : TextInputType.visiblePassword);

  @override
  // TODO: implement style
  TextStyle? get style => CustomTextStyle(
      context: context,
      fontSz: 16,
      fontWght: Fontweight.w400,
      scaleFactor: scaleFactor,
      colour: FontColour.black);

  const CustormTextField({
    super.key,
    required this.context,
    required this.isEmail,
    required this.controllerr,
  });
}
