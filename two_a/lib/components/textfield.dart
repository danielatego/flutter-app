import 'package:flutter/material.dart';
import 'package:two_a/components/text_style.dart';
import 'package:two_a/extensions/buildcontext/loc.dart';

enum Controllr { email, password }

class CustomTextField extends TextField {
  final TextEditingController controllerr;
  final BuildContext context;
  final bool isEmail;

  @override
  TextEditingController? get controller => controllerr;
  @override
  bool get obscureText => isEmail ? false : true;
  @override
  bool get enableSuggestions => false;
  @override
  TextInputType get keyboardType =>
      (isEmail ? TextInputType.emailAddress : TextInputType.visiblePassword);

  @override
  TextStyle? get style => CustomTextStyle(
      context: context,
      fontSz: 16,
      fontWght: Fontweight.w400,
      colour: FontColour.black);
  @override
  int? get maxLines => 1;

  @override
  InputDecoration? get decoration => (InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: 14.0 * context.scaleFactor[0],
          horizontal: 11.0 * context.scaleFactor[1],
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0XFF838383)),
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.0 * context.scaleFactor[0],
            ),
          ),
        ),
        hintText: isEmail
            ? context.loc.email_text_field_placeholder
            : context.loc.password_text_field_placeholder,
        hintStyle: CustomTextStyle(
          context: context,
          fontSz: 16,
          fontWght: Fontweight.w400,
          colour: FontColour.hintblack,
        ),
      ));

  const CustomTextField({
    super.key,
    required this.context,
    required this.isEmail,
    required this.controllerr,
  });
}
