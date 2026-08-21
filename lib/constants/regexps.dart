final spaceRegExp = RegExp(r"\s+");

//this is the regexp for rejecting first input as whitespace and two whitespaces in a row
final RegExp whitespaceRegExp = RegExp(r"\s\s");

//this is the regexp for rejecting first input as whitespace
final RegExp firstWhitespaceRegExp = RegExp(r"^\s+");

final emojiRegexp = RegExp(
  r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
);

final characterRegexp = RegExp(r'^[a-zA-Z]+$');

final digitsRegexp = RegExp('[0-9]');

final notAlphanumericRegexp = RegExp('[^a-zA-Z0-9]');

final alphanumericRegexp = RegExp(r'^[a-zA-Z0-9]+$');

final turkishCharactersRegexp = RegExp('[ığüşöçİĞÜŞÖÇ]');

//input must contains at least one uppercase, at least one lowercase and at least one special character
final RegExp passwordRegExp = RegExp(
  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[!@#\$&*~\=\-\_\%\+\.\,]).{8,}$',
);

final RegExp nonDigitsRegExp = RegExp(r'\D+');

// lowercase regexp
final RegExp lowercaseRegExp = RegExp('[a-z]');

// uppercase regexp
final RegExp uppercaseRegExp = RegExp('[A-Z]');

final RegExp specialCharacterRegExp = RegExp(r'[\.\,!@#\$&\*~=\-_%\+]');

final specialAndAlphaCharacters = RegExp(
  r"[a-zA-Z\$\R\Ü\Ö\T\Q\Ç\%\#\@\_\:\!\?\&\|\£\½\§\{\[\]\}\\\>\<\=\'\.\,\*\-\,+\ü\ğ\ö\ç\/\;(\) ]+$",
);

//this is the regexp for all non alpha numeric characters
final RegExp nonAlphaNumericRegExp = RegExp("[^a-zA-Z0-9]");
