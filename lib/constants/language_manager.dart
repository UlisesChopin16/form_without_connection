// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, ARABIC, SPANISH }

const String ARABIC = "ar";
const String ENGLISH = "en";
const String SPANISH = "es";
const String ASSETS_PATH_LOCALISATIONS = "assets/translations";
const Locale ARABIC_LOCAL = Locale("ar","SA");
const Locale ENGLISH_LOCAL = Locale("en","US");
const Locale SPANISH_LOCAL = Locale("es", "MX");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
      case LanguageType.SPANISH:
        return SPANISH;
    }
  }
}
