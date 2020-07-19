import 'package:flutter/material.dart';
import 'package:internationalization_ex/common/constants/date_time_format_constants.dart';
import 'package:internationalization_ex/common/internationalization.dart';
import 'package:internationalization_ex/common/extensions/string_extension.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String lastUpdate({BuildContext context, String languageCode}) {
    if (this == null) {
      return '';
    }

    final dateAgo = toString().dateAgoSinceDate(
        context: context,
        haveYesterday: false,
        dateFormat: DateTimeFormatConstants.ddMMMFormat);
    final timeAgo = toString().timeFormattedHHmm(languageCode: languageCode);
    final lastUpdate = S.of(context).translate('common.section.lastUpdated');
    return '$lastUpdate $dateAgo, $timeAgo';
  }

  String toStringWithFormat(String format) {
    final DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(this) ?? '';
  }

  bool isToday() {
    if (this == null) {
      return false;
    }
    final DateTime today = DateTime.now();

    return today.day == day && today.month == month && today.year == year;
  }

  bool isNotToday() {
    if (this == null) {
      return false;
    }
    final DateTime today = DateTime.now();

    return today.day != day || today.month != month || today.year != year;
  }

  bool isYesterday() {
    if (this == null) {
      return false;
    }
    final DateTime today = DateTime.now();
    const Duration twoDay = Duration(days: 2);

    final Duration difference = today.difference(this);

    if (difference.compareTo(twoDay) < 1) {
      return true;
    }

    return false;
  }

  String toDDMMMYYYYFormat(String languageCode) {
    return DateFormat(DateTimeFormatConstants.ddMMMyyyyFormat, languageCode)
        .format(this);
  }

  String toYYYYMMDDFormat() {
    return DateFormat(DateTimeFormatConstants.yyyyMMdd).format(this);
  }

  String toMMMYYYYFormat(String languageCode) {
    return DateFormat(DateTimeFormatConstants.mMMyyyyFormat, languageCode)
        .format(this);
  }

  DateTime getDateOnly() => DateTime(year, month, day);
}
