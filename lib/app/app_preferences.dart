// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:form_without_connection/constants/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";
const String PREFS_KEY_FORM_DATA = "PREFS_KEY_FORM_DATA";
const String PREFS_KEY_FORM_DATA_LIST = "PREFS_KEY_FORM_DATA_LIST";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.SPANISH.getValue();
    }
  }

  Future<void> setLanguageChanged(LanguageType type) async {
    _sharedPreferences.setString(PREFS_KEY_LANG, type.getValue());
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ARABIC.getValue()) {
      // return arabic local
      return ARABIC_LOCAL;
    }
    if (currentLanguage == LanguageType.ENGLISH.getValue()) {
      // return english local
      return ENGLISH_LOCAL;
    }
    return SPANISH_LOCAL;
  }

  Future<void> setUserToken(String token) async {
    _sharedPreferences.setString(PREFS_KEY_TOKEN, token);
  }

  Future<String> getUserToken() async {
    return _sharedPreferences.getString(PREFS_KEY_TOKEN) ?? "";
  }


  Future<void> setFormBeforeSend(String form) async {
    await _sharedPreferences.setString(PREFS_KEY_FORM_DATA, form);
  }

  Future<String> getFormBeforeSend() async {
    return _sharedPreferences.getString(PREFS_KEY_FORM_DATA) ?? "";
  }

  Future<void> clearFormBeforeSend() async {
    await _sharedPreferences.remove(PREFS_KEY_FORM_DATA);
  }



  Future<void> saveListFormWithoutWifi(List<String> list) async {
    await _sharedPreferences.setStringList(PREFS_KEY_FORM_DATA_LIST, list);
  }

  Future<List<String>> getListFormWithoutWifi() async {
    return _sharedPreferences.getStringList(PREFS_KEY_FORM_DATA_LIST) ?? [];
  }

  Future<void> clearListFormWithoutWifi() async {
    await _sharedPreferences.remove(PREFS_KEY_FORM_DATA_LIST);
  }
}
