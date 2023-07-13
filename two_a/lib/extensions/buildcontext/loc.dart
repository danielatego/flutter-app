import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_gen/gen_l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:two_a/components/mediaquery.dart';

extension Localization on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
  List get scaleFactor {
    final media = MQuery(context: this);
    List sf = [
      media.heightscalefactor(),
      media.widthScalefactor(),
      media.heigthmarginfactor(),
      media.widthHeight()
    ];
    return sf;
  }
}
