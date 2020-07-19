import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

import 'package:flutter_movie_app/common/constants/date_time_format_constants.dart';
import 'package:flutter_movie_app/common/extensions/date_time_extensions.dart';
import 'package:flutter_movie_app/domain/entities/language_reference_entity.dart';
import 'constants/language_constants.dart';

const _supportedLanguages = [
  Locale(LanguageConstants.english),
  Locale(LanguageConstants.vietnamese),
];

class SLocalizationsDelegate extends LocalizationsDelegate<S> {
  final List<LanguageReferenceEntity> languageReferences;

  SLocalizationsDelegate({this.languageReferences});

  @override
  bool isSupported(Locale locale) => [
        LanguageConstants.english,
        LanguageConstants.vietnamese
      ].contains(locale.languageCode);

  @override
  Future<S> load(Locale locale) async {
    final localizations = S();
    await localizations.load(locale, languageReferences: languageReferences);
    return localizations;
  }

  @override
  bool shouldReload(SLocalizationsDelegate old) => !listEquals(
        old.languageReferences,
        languageReferences,
      );
}

class S {
  static final S _instance = S._internal();

  factory S() {
    return _instance;
  }

  S._internal();

  String localeName;
  List<LanguageReferenceEntity> languageReferences;
  Map<String, String> _sentences;
  final Map<String, Map<String, String>> _cachedData = {};

  Map _mapLanguageReference() {
    for (final LanguageReferenceEntity languageReference
        in languageReferences) {
      localeName == LanguageConstants.english
          ? _sentences[languageReference.code] = languageReference.english
          : _sentences[languageReference.code] = languageReference.vietnamese;
    }
    return _sentences;
  }

  Future<void> _loadData() async {
    final loads = _supportedLanguages.map(_loadLocaleData);

    await Future.wait(loads);
  }

  Future<void> _loadLocaleData(Locale locale) async {
    final data =
        await rootBundle.loadString('languages/${locale.languageCode}.json');
    final result = json.decode(data);
    final Map<String, String> sentences = Map();
    result.forEach((String key, dynamic value) {
      sentences[key] = value.toString();
    });
    _cachedData[locale.languageCode] = sentences;
  }

  Future<bool> load(Locale locale,
      {List<LanguageReferenceEntity> languageReferences}) async {
    localeName = locale.languageCode;
    this.languageReferences = languageReferences;

    if (_cachedData[localeName] == null) {
      await _loadData();
    }
    _sentences = _cachedData[localeName];

    if (languageReferences != null) {
      _mapLanguageReference();
    }
    return true;
  }

  // ignore: prefer_constructors_over_static_methods
  static S of(BuildContext context) {
    return Localizations.of<S>(context, S) ?? S();
  }

  String translate(String key, {List<dynamic> params = const []}) {
    if (localeName == null || _sentences == null || _sentences.isEmpty) {
      return key;
    }
    return _sentences[key] == null ? key : sprintf(_sentences[key], params);
  }

  String dateTimeFormat(DateTime dateTime,
      {String format = DateTimeFormatConstants.defaultDateTimeFormat}) {
    return DateFormat(format, localeName).format(dateTime);
  }

  String dateTimeFormatExceptTodayAndYesterday(DateTime dateTime,
      {String format = DateTimeFormatConstants.ddMMMyyyyFormat}) {
    if (dateTime.isToday()) {
      return translate('common.day.today');
    }
    if (dateTime.isYesterday()) {
      return translate('common.day.yesterday');
    }
    return dateTimeFormat(dateTime, format: format);
  }
}
