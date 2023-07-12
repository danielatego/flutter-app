import 'package:flutter/material.dart';

class MQuery {
  BuildContext context;

  double heightscalefactor() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return (MediaQuery.of(context).size.height - 30) / 667;
    } else {
      return 1.2;
    }
  }

  double heigthmarginfactor() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return (MediaQuery.of(context).size.height - 30) / 667;
    } else {
      return 0.75;
    }
  }

  double widthScalefactor() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return (MediaQuery.of(context).size.width) / 375;
    } else {
      return 1.2;
    }
  }

  MQuery({required this.context});
}
