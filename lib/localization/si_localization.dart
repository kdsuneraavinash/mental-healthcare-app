import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _MaterialLocalizationsSiDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _MaterialLocalizationsSiDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'si';

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      MaterialLocalizationSi();

  @override
  bool shouldReload(_MaterialLocalizationsSiDelegate old) => false;

  @override
  String toString() => 'MaterialLocalizationsSi.delegate(si_LK)';
}

class MaterialLocalizationSi implements MaterialLocalizations {
  const MaterialLocalizationSi();

  static const List<String> _shortWeekdays = <String>[
    'සඳුදා',
    'අඟ',
    'බදාදා',
    'බ්‍රහස්',
    'සිකු',
    'සෙන',
    'ඉරිදා',
  ];

  // Ordered to match DateTime.monday=1, DateTime.sunday=6
  static const List<String> _weekdays = <String>[
    'සඳුදා',
    'අඟහරුවාදා',
    'බදාදා',
    'බ්‍රහස්පතින්දා',
    'සිකුරාදා',
    'සෙනසුරාදා',
    'ඉරිදා',
  ];

  static const List<String> _narrowWeekdays = <String>[
    'ඉ',
    'ස',
    'අ',
    'බ',
    'බ්‍ර',
    'සි',
    'සෙ',
  ];

  static const List<String> _shortMonths = <String>[
    'ජනවා',
    'පෙබ',
    'මාර්තු',
    'අප්‍රි',
    'මැයි',
    'ජුනි',
    'ජූලි',
    'අගෝ',
    'සෙප්',
    'ඔක්තො',
    'නොවෙ',
    'දෙසෙ',
  ];

  static const List<String> _months = <String>[
    'ජනවාරි',
    'පෙබරවාරි',
    'මාර්තු',
    'අප්‍රේල්',
    'මැයි',
    'ජූනි',
    'ජූලි',
    'අගෝස්තු',
    'සැප්තැම්බර්',
    'ඔක්තෝම්බර්',
    'නොවෙම්බර්',
    'දෙසැම්බර්',
  ];

  @override
  String formatHour(TimeOfDay timeOfDay, {bool alwaysUse24HourFormat = false}) {
    final TimeOfDayFormat format =
        timeOfDayFormat(alwaysUse24HourFormat: alwaysUse24HourFormat);
    switch (format) {
      case TimeOfDayFormat.h_colon_mm_space_a:
        return formatDecimal(
            timeOfDay.hourOfPeriod == 0 ? 12 : timeOfDay.hourOfPeriod);
      case TimeOfDayFormat.HH_colon_mm:
        return _formatTwoDigitZeroPad(timeOfDay.hour);
      default:
        throw AssertionError('$runtimeType does not support $format.');
    }
  }

  String _formatTwoDigitZeroPad(int number) {
    assert(0 <= number && number < 100);
    if (number < 10) return '0$number';
    return '$number';
  }

  @override
  String formatMinute(TimeOfDay timeOfDay) {
    final int minute = timeOfDay.minute;
    return minute < 10 ? '0$minute' : minute.toString();
  }

  @override
  String formatYear(DateTime date) => date.year.toString();

  @override
  String formatMediumDate(DateTime date) {
    final String day = _shortWeekdays[date.weekday - DateTime.monday];
    final String month = _shortMonths[date.month - DateTime.january];
    return '$day, $month ${date.day}';
  }

  @override
  String formatFullDate(DateTime date) {
    final String month = _months[date.month - DateTime.january];
    return '${_weekdays[date.weekday - DateTime.monday]}, $month ${date.day}, ${date.year}';
  }

  @override
  String formatMonthYear(DateTime date) {
    final String year = formatYear(date);
    final String month = _months[date.month - DateTime.january];
    return '$month $year';
  }

  @override
  List<String> get narrowWeekdays => _narrowWeekdays;

  @override
  int get firstDayOfWeekIndex => 1; // First day is considered Monday

  String _formatDayPeriod(TimeOfDay timeOfDay) {
    switch (timeOfDay.period) {
      case DayPeriod.am:
        return anteMeridiemAbbreviation;
      case DayPeriod.pm:
        return postMeridiemAbbreviation;
    }
    return null;
  }

  @override
  String formatDecimal(int number) {
    if (number > -1000 && number < 1000) return number.toString();

    final String digits = number.abs().toString();
    final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
    final int maxDigitIndex = digits.length - 1;
    for (int i = 0; i <= maxDigitIndex; i += 1) {
      result.write(digits[i]);
      if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) result.write(',');
    }
    return result.toString();
  }

  @override
  String formatTimeOfDay(TimeOfDay timeOfDay,
      {bool alwaysUse24HourFormat = false}) {
    final StringBuffer buffer = StringBuffer();
    buffer
      ..write(
          formatHour(timeOfDay, alwaysUse24HourFormat: alwaysUse24HourFormat))
      ..write(':')
      ..write(formatMinute(timeOfDay));

    if (alwaysUse24HourFormat) {
      return '$buffer';
    }

    buffer..write(' ')..write(_formatDayPeriod(timeOfDay));
    return '$buffer';
  }

  @override
  String get openAppDrawerTooltip => 'Navigation මෙනුව';

  @override
  String get backButtonTooltip => 'පිටුපසට යන්න';

  @override
  String get closeButtonTooltip => 'වසා දමන්න';

  @override
  String get deleteButtonTooltip => 'මකන්න';

  @override
  String get nextMonthTooltip => 'ඊලඟ මාසය';

  @override
  String get previousMonthTooltip => 'පෙර මාසය';

  @override
  String get nextPageTooltip => 'ඊලඟ පිටුව';

  @override
  String get previousPageTooltip => 'පෙර පිටුව';

  @override
  String get showMenuTooltip => 'මෙනුව පෙන්වන්න';

  @override
  String get drawerLabel => 'Navigation මෙනුව';

  @override
  String get popupMenuLabel => 'Popup මෙනුව';

  @override
  String get dialogLabel => 'Dialog තිරය';

  @override
  String get alertDialogLabel => 'අනතුරු ඇඟවීමයි';

  @override
  String get searchFieldLabel => 'සොයන්න';

  @override
  String aboutListTileTitle(String applicationName) =>
      '$applicationName එක පිලිබඳව';

  @override
  String get licensesPageTitle => 'බලපත්ර';

  @override
  String pageRowsInfoTitle(
      int firstRow, int lastRow, int rowCount, bool rowCountIsApproximate) {
    return rowCountIsApproximate
        ? 'තීරු $rowCount කින් පමණ තීරු $firstRow - $lastRow'
        : 'තීරු $rowCount කින් තීරු $firstRow - $lastRow';
  }

  @override
  String get rowsPerPageTitle => 'පිටුවකට තීරු:';

  @override
  String tabLabel({int tabIndex, int tabCount}) {
    assert(tabIndex >= 1);
    assert(tabCount >= 1);
    return 'Tab $tabCount කින් $tabIndex';
  }

  @override
  String selectedRowCountTitle(int selectedRowCount) {
    switch (selectedRowCount) {
      case 0:
        return 'අයිතම තෝරා නැත';
      case 1:
        return 'එක අයිතමයක් තෝරා ඇත';
      default:
        return 'අයිතම $selectedRowCount ක් තෝරා ඇත';
    }
  }

  @override
  String get cancelButtonLabel => 'නවත්වන්න';

  @override
  String get closeButtonLabel => 'වහන්න';

  @override
  String get continueButtonLabel => 'ඉදිරියට යන්න';

  @override
  String get copyButtonLabel => 'COPY කරන්න';

  @override
  String get cutButtonLabel => 'CUT කරන්න';

  @override
  String get okButtonLabel => 'හරි';

  @override
  String get pasteButtonLabel => 'PASTE කරන්න';

  @override
  String get selectAllButtonLabel => 'සියල්ලම තෝරන්න';

  @override
  String get viewLicensesButtonLabel => 'බලපත්‍ර පෙන්වන්න';

  @override
  String get anteMeridiemAbbreviation => 'පෙව';

  @override
  String get postMeridiemAbbreviation => 'පව';

  @override
  String get timePickerHourModeAnnouncement => 'පැය තෝරන්න';

  @override
  String get timePickerMinuteModeAnnouncement => 'මිනිත්තු තෝරන්න';

  @override
  String get modalBarrierDismissLabel => 'වසා දමන්න';

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) {
    return alwaysUse24HourFormat
        ? TimeOfDayFormat.HH_colon_mm
        : TimeOfDayFormat.h_colon_mm_space_a;
  }

  @override
  String get signedInLabel => 'Sign in වී ඇත';

  @override
  String get hideAccountsLabel => 'Accounta සගවන්න';

  @override
  String get showAccountsLabel => 'Accounta පෙන්වන්න';

  @override
  String get reorderItemUp => 'උඩට යන්න';

  @override
  String get reorderItemDown => 'පහලට යන්න ';

  @override
  String get reorderItemLeft => 'වමට යන්න';

  @override
  String get reorderItemRight => 'දකුනට යන්න';

  @override
  String get reorderItemToEnd => 'අවසානයට යන්න';

  @override
  String get reorderItemToStart => 'ආරම්භයට යන්න';

  @override
  String get expandedIconTapHint => 'වසන්න';

  @override
  String get collapsedIconTapHint => 'දිගහරින්න';

  @override
  String get refreshIndicatorSemanticLabel => 'Refresh කරන්න';

  static Future<MaterialLocalizations> load(Locale locale) {
    return SynchronousFuture<MaterialLocalizations>(
        const MaterialLocalizationSi());
  }

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _MaterialLocalizationsSiDelegate();

  @override
  String remainingTextFieldCharacterCount(int remaining) {
    switch (remaining) {
      case 0:
        return 'අකුරු තව නොමැත';
      case 1:
        return 'තව එක අකුරක් පමණක් ඇත';
      default:
        return 'අකුරු $remaining ක් ඇත';
    }
  }
}
