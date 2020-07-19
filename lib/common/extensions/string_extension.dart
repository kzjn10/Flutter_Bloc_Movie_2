import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_movie_app/common/constants/date_time_format_constants.dart';
import 'package:flutter_movie_app/common/constants/language_constants.dart';
import 'package:flutter_movie_app/common/constants/string_constants.dart';
import 'package:flutter_movie_app/common/internationalization.dart';

extension StringExtensions on String {
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

  String timeFormattedHHmmss({String languageCode}) {
    final date = DateTime.parse(this).toLocal();
    final stringFormat = languageCode == LanguageConstants.vietnamese
        ? DateTimeFormatConstants.timeHHmmssFormatVI
        : DateTimeFormatConstants.timeHHmmssFormatEN;
    final formatted = DateFormat(stringFormat).format(date);
    return formatted;
  }
}
