import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter_movie_app/common/constants/date_time_format_constants.dart';
import 'package:flutter_movie_app/common/extensions/string_extension.dart';
import 'package:flutter_movie_app/common/internationalization.dart';

extension DateTimeExt on DateTime {
  String lastUpdate({BuildContext context, String languageCode}) {
    if (this == null) {
      return '';
    }

    final dateAgo = toString().dateAgoSinceDate(
        context: context,
        haveYesterday: false,
        dateFormat: DateTimeFormatConstants.ddMMMFormat);
    final timeAgo = toString().timeFormattedHHmmss(languageCode: languageCode);
    final lastUpdate = S.of(context).translate('common.section.lastUpdated');
    return '$lastUpdate $dateAgo, $timeAgo';
  }

  String toStringWithFormat(String format) {
    final dateFormat = DateFormat(format);
    return dateFormat.format(this) ?? '';
  }

  bool isToday() {
    if (this == null) {
      return false;
    }
    final today = DateTime.now();

    return today.day == day && today.month == month && today.year == year;
  }

  bool isNotToday() {
    if (this == null) {
      return false;
    }
    final today = DateTime.now();

    return today.day != day || today.month != month || today.year != year;
  }

  bool isYesterday() {
    if (this == null) {
      return false;
    }
    final today = DateTime.now();
    const twoDay = Duration(days: 2);

    final difference = today.difference(this);

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
