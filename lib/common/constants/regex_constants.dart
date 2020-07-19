class RegexConstants {
  static const String hasDigitRegex = r'[0-9]';
  static const String hasLowerCaseRegex = r'[a-z]';
  static const String hasUpperCaseRegex = r'[A-Z]';
  static const String alphabetRegex = r'[a-zA-Z]';
  static const String validPhoneBook =
      r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]';

  static const String validPhoneRegex =
      r'^[0-9]{8,17}$'; //Phone number should be in range 8 to 17 chars

  static const String hasSpaceCharacter =
      r' '; //Phone number should be in range 3 to 15 chars

  static const String validEmailRegex =
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'; // I got Regex pattern from this https://stackoverflow.com/a/50663835

  static const String hasOnlyDigitRegex = r'^[0-9]*$';
  static const String hasOnlyAlphabetsRegex = r'^[a-zA-Z]*$';
  static const String hasOnlyAlphanumericWithAtLeastOneAlphabetRegex =
      r'^\d*[a-zA-Z][a-zA-Z0-9]*$';
  static const String hasSpecialCharacterRegex = r'[\W_]';

  static const String hexcolor = r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$';
  static const String numericRegex = r'^-?[0-9]+$';

  static const String checkSpecialCharForPhoneNumber = '[-()\\s]';
  static const String phoneNumberCountryCode = '^(0|62|\\+62)';
  static const String phoneNumberCompanyRegex =
      r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[\s\ 0-9]*$';
  static const String checkContactNameWithLastIndex = r'\((\d+).$';
  static const String phonePrefix = r'(0|\+62)';
  static const String eKTPRegex = r'^[0-9]{16}$';
  static const String pipeline = r'|';
  static const String simpleEmailValidate = r'@{1}\w+\.+';
}
