import 'package:flutter/cupertino.dart';

import 'constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String convertSessionThemeLang(String genre, BuildContext context) {
  switch (genre) {
    case "Relaxation":
      {
        return LangLocal.of(context)!.relaxation;
      }
    case "Stress Free":
      {
        return LangLocal.of(context)!.stress_free;
      }
    case "Peaceful":
      {
        return LangLocal.of(context)!.peaceful;
      }
    case "Meditation":
      {
        return LangLocal.of(context)!.meditation;
      }
    case "Sleep":
      {
        return LangLocal.of(context)!.sleep;
      }
    case "Motivation":
      {
        return LangLocal.of(context)!.motivation;
      }
  }

  return "Error";
}
