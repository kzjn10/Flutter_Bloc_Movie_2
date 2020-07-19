import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:internationalization_ex/common/constants/date_time_format_constants.dart';
import 'package:internationalization_ex/common/constants/language_constants.dart';
import 'package:internationalization_ex/common/constants/regex_constants.dart';
import 'package:internationalization_ex/common/constants/string_constants.dart';
import 'package:internationalization_ex/common/internationalization.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

extension StringExtensions on String {
  bool get hasOnlyWhitespaces => trim().isEmpty && isNotEmpty;

  bool get isEmptyOrNull {
    if (this == null) {
      return true;
    }
    return isEmpty;
  }

  bool get isNotNullAndEmpty => this != null && isNotEmpty;

  String toSpaceSeparated() {
    final value =
        replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
    return value;
  }

  String replaceStringWithPadLeft(String newValue, int until, int padWidth) {
    final value = replaceRange(0, until, '').padLeft(padWidth, newValue);
    return value;
  }

  String mapQueryToTextTag({String textQuery}) {
    try {
      for (int i = 0; i < length; i++) {
        if (this[i].toLowerCase() == textQuery[0].toLowerCase()) {
          if (i + textQuery.length <= length) {
            final String temp = substring(i, i + textQuery.length);
            if (temp.toLowerCase() == textQuery.toLowerCase()) {
              return replaceAll(temp, '<b>$temp</b>');
            }
          }
        }
      }
      return this;
    } catch (e) {
      return this;
    }
  }

  String get getCharacterAvatar {
    if (this != null) {
      final re = RegExp(r'\b(\w)');
      var nameLabel = '';
      final Iterable<Match> matches = re.allMatches(this);
      if (matches.isNotEmpty) {
        final firstCharacter = matches.first?.group(0)?.toUpperCase() ?? '';
        final lastCharacter = matches.last?.group(0)?.toUpperCase() ?? '';
        nameLabel = matches.length > 1
            ? '$firstCharacter$lastCharacter'
            : '$firstCharacter';
      }

      return nameLabel.toString();
    }
    return '';
  }

  String get addPrefixPhoneNumber {
    if (this != null) {
      return hasPhoneNumberCountryCode
          ? replaceAll(
              RegExp(RegexConstants.phoneNumberCountryCode),
              '+$phoneIndoNationPrefixNumber',
            )
          : '+$phoneIndoNationPrefixNumber$this';
    }
    return '';
  }

  String get removeAllSpaceCharacters =>
      replaceAll(RegexConstants.hasSpaceCharacter, '');

  bool get isValidEmailString =>
      this != null && RegExp(RegexConstants.validEmailRegex).hasMatch(trim());

  bool get validPasswordString =>
      this != null &&
      RegExp(RegexConstants.hasLowerCaseRegex).hasMatch(trim()) &&
      RegExp(RegexConstants.hasUpperCaseRegex).hasMatch(trim()) &&
      RegExp(RegexConstants.hasDigitRegex).hasMatch(trim()) &&
      length >= 9;

  bool get validKTPNumberString =>
      this != null &&
      RegExp(RegexConstants.hasOnlyDigitRegex).hasMatch(trim()) &&
      length > 15;

  bool get hasPhoneNumberCountryCode =>
      this != null &&
      RegExp(RegexConstants.phoneNumberCountryCode).hasMatch(trim());

  String get preparePhoneNumberString {
    const int firstSpaceCharacterIndex = 4;
    const int secondSpaceCharacterIndex = 8;

    final int newTextLength = length;
    final StringBuffer newText = StringBuffer();
    int usedSubstringIndex = 0;

    if (newTextLength >= firstSpaceCharacterIndex) {
      usedSubstringIndex = firstSpaceCharacterIndex - 1;
      newText.write('${substring(0, usedSubstringIndex)} ');
    }

    if (newTextLength >= secondSpaceCharacterIndex) {
      usedSubstringIndex = secondSpaceCharacterIndex - 1;
      const startIndex = firstSpaceCharacterIndex - 1;
      newText.write('${substring(startIndex, usedSubstringIndex)} ');
    }

    // Add the rest to new text
    if (newTextLength >= usedSubstringIndex) {
      newText.write(substring(usedSubstringIndex));
    }
    return newText.toString();
  }

  String get prepareHashedPhoneNumber {
    final phone = replaceAll(' ', '');
    if (this != null && phone.length >= 7) {
      final endHashIndex = phone.length - 3;
      final startHashIndex = endHashIndex - 4;

      return '''${phone.substring(0, startHashIndex)}****${phone.substring(endHashIndex)}''';
    }
    return phone ?? '';
  }

  String separateAfterNCharacter(int position, String separator) {
    final newString = replaceAllMapped(RegExp(r'.{' '$position' '}'), (match) {
      return '${match.group(0)}$separator';
    });

    if (newString.endsWith(separator)) {
      return newString.substring(0, newString.lastIndexOf(separator));
    }
    return newString;
  }

  String removeAllSeparatorFromCharacter(String separator) {
    return replaceAll(RegExp(r'\' '$separator'), '');
  }

  String removeAllWord(List<String> words) {
    if (words != null && words.isNotEmpty) {
      String result = this;
      for (int i = 0; i < words.length; i++) {
        result = result.replaceAll(words[i], '');
      }
      return result;
    }
    return this;
  }

  String dateAgoSinceDate(
      {BuildContext context,
      bool haveYesterday = true,
      String dateFormat = '',
      String languageCode = LanguageConstants.vietnamese}) {
    initializeDateFormatting();

    final date = DateTime.parse(this).toLocal();
    final now = DateTime.now();
    final difference = now.difference(date);
    final formatDateString = dateFormat.isNotEmpty
        ? dateFormat
        : DateTimeFormatConstants.dMMMyyyyFormat;

    if (difference.inDays == 0) {
      return S.of(context).translate(today);
    }
    if (haveYesterday && difference.inDays == 1) {
      return S.of(context).translate(yesterday);
    }

    final formattedDate =
        DateFormat(formatDateString, languageCode).format(date);

    return formattedDate;
  }

  String timeFormattedHHmm({String languageCode}) {
    final date = DateTime.parse(this).toLocal();
    final fomatString = languageCode == LanguageConstants.vietnamese
        ? DateTimeFormatConstants.timeHHmmFormatID
        : DateTimeFormatConstants.timeHHmmFormatEN;
    final formatted = DateFormat(fomatString).format(date);
    return formatted;
  }

  String timeFormattedHHmmss({String languageCode}) {
    final date = DateTime.parse(this).toLocal();
    final stringFormat = languageCode == LanguageConstants.vietnamese
        ? DateTimeFormatConstants.timeHHmmssFormatID
        : DateTimeFormatConstants.timeHHmmssFormatEN;
    final formatted = DateFormat(stringFormat).format(date);
    return formatted;
  }

  String get timeFormatteddMMMyyyy {
    final date = DateTime.parse(this).toLocal();
    final formatted =
        DateFormat(DateTimeFormatConstants.dMMMyyyyFormat).format(date);
    return formatted;
  }

  String get timeFormattedMMyy {
    final date = DateTime.parse(this).toLocal();
    final formatted = DateFormat(DateTimeFormatConstants.mmyy).format(date);
    return formatted;
  }

  String timeFomattedDateTime({String languageCode}) {
    final date = DateTime.parse(this).toLocal();
    final stringFormat = languageCode == LanguageConstants.vietnamese
        ? DateTimeFormatConstants.dMMMyyyyHHmmFormatID
        : DateTimeFormatConstants.dMMMyyyyHHmmFormatEN;
    final formatted = DateFormat(stringFormat, languageCode).format(date);
    return formatted;
  }

  String timeFormatted({String languageCode}) {
    final date = DateTime.now().toLocal();
    const stringFormat = DateTimeFormatConstants.timeMMMMyyyy;
    final formatted = DateFormat(stringFormat, languageCode).format(date);
    return formatted;
  }

  String allWordsCapitilize() {
    return split(' ').map((word) {
      final String leftText =
          (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  String removeSpecialCharForPhoneNumber() {
    return replaceAll(
        RegExp(RegexConstants.checkSpecialCharForPhoneNumber), '');
  }

  String allWordsCapitilizeAndtoUpperCase() {
    return toLowerCase().split(' ').map((word) {
      final String leftText =
          (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  String getLastCharacterIntFromText() {
    final text =
        RegExp(RegexConstants.checkContactNameWithLastIndex).stringMatch(this);
    return text?.substring(1, text.length - 1);
  }

  String toCurrency() {
    return 'Rp$this';
  }

  String splitLongStringForLogging() {
    return splitMapJoin(
      RegExp('.{1000}'),
      onMatch: (match) => '${match.group(0)}',
      onNonMatch: (last) => '\n$last',
    );
  }

  String suffixDate(String languageCode) {
    String date = this;

    if (languageCode == LanguageConstants.vietnamese) {
      return date;
    }

    if (endsWith('1')) {
      date += 'st';
    } else if (endsWith('2')) {
      date += 'nd';
    } else if (endsWith('3')) {
      date += 'rd';
    } else {
      date += 'th';
    }
    return date;
  }

  bool isURL() {
    const pattern =
        r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
    return RegExp(pattern, caseSensitive: false).hasMatch(this);
  }

  String excludePrefixURLIfNeeded() {
    if (!isURL()) {
      return this;
    }

    final uri = Uri.parse(this);
    return uri.path;
  }

  Map<String, String> getQueryParameters() {
    final uri = Uri.parse(this);
    return uri.queryParameters;
  }

  String generatePrefixWithRandomNumeric(int digitCount) {
    String s = '';
    final _random = Random();
    for (var i = 0; i < digitCount; i++) {
      // ignore: use_string_buffers
      s += _random.nextInt(10).toString();
    }
    return this + s;
  }

  String get getCharactersDukcapil {
    if (this != null) {
      return this;
    }
    return '';
  }

  Uri get uri => Uri.tryParse(this);

  bool get isUri => uri.isAbsolute;

  String get uriPath => uri.path;

  String get normalize => path.normalize(this);

  String get baseName => path.basename(this);

  String get dirName => path.dirname(this);

  File get file => File(this);

  Directory get directory => Directory(this);

  double toDouble() => double.tryParse(this);

  String allReplace(List<String> listReplace) {
    String textResult = this;
    for (final string in listReplace) {
      textResult = textResult.replaceAll(
        string,
        '',
      );
    }

    return textResult;
  }

  String formatPhoneNumber(String countryCallingCodeID) {
    if (isEmpty || substring(0, 3) == '+$countryCallingCodeID') {
      return this;
    }

    if (this[0] == '0') {
      return '+$countryCallingCodeID${substring(1)}';
    } else if (substring(0, 2) == '$countryCallingCodeID') {
      return '+$this';
    } else if (this[0] != '0') {
      return '+$countryCallingCodeID$this';
    }

    return this;
  }

  String capitalizeToFirst() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
