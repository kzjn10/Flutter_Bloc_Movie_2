class DateTimeFormatConstants {
  static const iso8601WithMillisecondsOnly = 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'';
  static const defaultDateTimeFormat = 'EEEE, d MMM y';
  static const dMMMyyyyHHmmFormatID = 'd MMM yyyy, HH.mm';
  static const dMMMyyyyHHmmFormatEN = 'd MMM yyyy, HH:mm';
  static const dMMMyyyyFormat = 'd MMM yyyy';
  static const ddMMMyyyyFormat = 'dd MMM yyyy';
  static const dMMMMyyyyFormat = 'd MMMM yyyy';
  static const ddMMyyyyFormat = 'ddMMyyyy';
  static const mMMyyyyFormat = 'MMM yyyy';
  static const ddMMMFormat = 'd MMM';
  static const timeHHmmssFormatID = 'HH.mm.ss';
  static const timeHHmmssFormatEN = 'HH:mm:ss';
  static const timeHHmmFormatID = 'HH.mm';
  static const timeHHmmFormatEN = 'HH:mm';
  static const eEEEdMMMMyFormat = 'EEEE, d MMMM y';
  static const yyyyMMdd = 'yyyy-MM-dd';
  static const day = 'dd';
  static const weekday = 'EEEE';
  static const month = 'MMM';
  static const ddMMMMyyyy = 'dd MMMM yyyy';
  static const timeMMMMyyyy = 'MMMM yyyy';
  static const mmyy = 'MM/yy';
  static const timeSeparater = ':';
  static const String monthFull = 'MMMM';
  static const String year = 'y';

  static const scheduleVideoKycCallDateFormat = 'dd-MM-yyyy';
  static const scheduleVideoKycCallTimeFormat = 'HH:mm';
}

class DateTimeCalendarConstants {
  static DateTime defaultTomorrowISODate =
      DateTime.now().add(const Duration(days: 1));
  static DateTime defaultMaxDate =
      defaultTomorrowISODate.add(const Duration(days: 3650));
  static DateTime defaultMinDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  static DateTime tomorrowDate = DateTime(defaultTomorrowISODate.year,
      defaultTomorrowISODate.month, defaultTomorrowISODate.day);
  static Duration timeDifferenceOfGMTWithWIB = const Duration(hours: 7);
  static const int totalHoursInDay = 24;
  static const int defaultHoursRemaining = 1;
}
