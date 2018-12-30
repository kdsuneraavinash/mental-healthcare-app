import 'package:flutter/material.dart';

class MaterialLocalizationSiDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return locale.countryCode == "LK" && locale.languageCode == "si";
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return MaterialLocalizationSi();
  }

  @override
  bool shouldReload(old) {
    return false;
  }
}

class MaterialLocalizationSi extends MaterialLocalizations {
  @override
  String aboutListTileTitle(String applicationName) {
    return "About $applicationName";
  }

  @override
  String get alertDialogLabel => "Alert";

  @override
  String get anteMeridiemAbbreviation => "AM";

  @override
  String get backButtonTooltip => "Back";

  @override
  String get cancelButtonLabel => "CANCEL";

  @override
  String get closeButtonLabel => "CLOSE";

  @override
  String get closeButtonTooltip => "Close";

  @override
  String get continueButtonLabel => "CONTINUE";

  @override
  String get copyButtonLabel => "COPY";

  @override
  String get cutButtonLabel => "CUT";

  @override
  String get deleteButtonTooltip => "Delete";

  @override
  String get dialogLabel => "Dialogue";

  @override
  String get drawerLabel => "Navigation menu";

  @override
  int get firstDayOfWeekIndex =>
      DefaultMaterialLocalizations().firstDayOfWeekIndex;

  @override
  String formatDecimal(int number) {
    return DefaultMaterialLocalizations().formatDecimal(number);
  }

  @override
  String formatFullDate(DateTime date) {
    return DefaultMaterialLocalizations().formatFullDate(date);
  }

  @override
  String formatHour(TimeOfDay timeOfDay, {bool alwaysUse24HourFormat = false}) {
    return DefaultMaterialLocalizations()
        .formatHour(timeOfDay, alwaysUse24HourFormat: alwaysUse24HourFormat);
  }

  @override
  String formatMediumDate(DateTime date) {
    return DefaultMaterialLocalizations().formatMediumDate(date);
  }

  @override
  String formatMinute(TimeOfDay timeOfDay) {
    return DefaultMaterialLocalizations().formatMinute(timeOfDay);
  }

  @override
  String formatMonthYear(DateTime date) {
    return DefaultMaterialLocalizations().formatMonthYear(date);
  }

  @override
  String formatTimeOfDay(TimeOfDay timeOfDay,
      {bool alwaysUse24HourFormat = false}) {
    return DefaultMaterialLocalizations().formatTimeOfDay(timeOfDay,
        alwaysUse24HourFormat: alwaysUse24HourFormat);
  }

  @override
  String formatYear(DateTime date) {
    return DefaultMaterialLocalizations().formatYear(date);
  }

  @override
  String get hideAccountsLabel => "Hide accounts";

  @override
  // TODO: implement licensesPageTitle
  String get licensesPageTitle => "Licences";

  @override
  // TODO: implement modalBarrierDismissLabel
  String get modalBarrierDismissLabel => "Dismiss";

  @override
  // TODO: implement narrowWeekdays
  List<String> get narrowWeekdays =>
      DefaultMaterialLocalizations().narrowWeekdays;

  @override
  // TODO: implement nextMonthTooltip
  String get nextMonthTooltip => "Next month";

  @override
  // TODO: implement nextPageTooltip
  String get nextPageTooltip => "";

  @override
  // TODO: implement okButtonLabel
  String get okButtonLabel => "";

  @override
  // TODO: implement openAppDrawerTooltip
  String get openAppDrawerTooltip => "";

  @override
  String pageRowsInfoTitle(
      int firstRow, int lastRow, int rowCount, bool rowCountIsApproximate) {
    // TODO: implement pageRowsInfoTitle
    return "";
  }

  @override
  // TODO: implement pasteButtonLabel
  String get pasteButtonLabel => "";

  @override
  // TODO: implement popupMenuLabel
  String get popupMenuLabel => "";

  @override
  // TODO: implement postMeridiemAbbreviation
  String get postMeridiemAbbreviation => "";

  @override
  // TODO: implement previousMonthTooltip
  String get previousMonthTooltip => "";

  @override
  // TODO: implement previousPageTooltip
  String get previousPageTooltip => "";

  @override
  // TODO: implement refreshIndicatorSemanticLabel
  String get refreshIndicatorSemanticLabel => "";

  @override
  String remainingTextFieldCharacterCount(int remaining) {
    // TODO: implement remainingTextFieldCharacterCount
    return "";
  }

  @override
  // TODO: implement reorderItemDown
  String get reorderItemDown => "";

  @override
  // TODO: implement reorderItemLeft
  String get reorderItemLeft => "";

  @override
  // TODO: implement reorderItemRight
  String get reorderItemRight => "";

  @override
  // TODO: implement reorderItemToEnd
  String get reorderItemToEnd => "";

  @override
  // TODO: implement reorderItemToStart
  String get reorderItemToStart => "";

  @override
  // TODO: implement reorderItemUp
  String get reorderItemUp => "";

  @override
  // TODO: implement rowsPerPageTitle
  String get rowsPerPageTitle => "";

  @override
  // TODO: implement scriptCategory
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => "";

  @override
  // TODO: implement selectAllButtonLabel
  String get selectAllButtonLabel => "";

  @override
  String selectedRowCountTitle(int selectedRowCount) {
    // TODO: implement selectedRowCountTitle
    return "";
  }

  @override
  // TODO: implement showAccountsLabel
  String get showAccountsLabel => "";

  @override
  // TODO: implement showMenuTooltip
  String get showMenuTooltip => "";

  @override
  // TODO: implement signedInLabel
  String get signedInLabel => "";

  @override
  String tabLabel({int tabIndex, int tabCount}) {
    // TODO: implement tabLabel
    return "";
  }

  @override
  TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) {
    // TODO: implement timeOfDayFormat
    return DefaultMaterialLocalizations()
        .timeOfDayFormat(alwaysUse24HourFormat: alwaysUse24HourFormat);
  }

  @override
  // TODO: implement timePickerHourModeAnnouncement
  String get timePickerHourModeAnnouncement => "";

  @override
  // TODO: implement timePickerMinuteModeAnnouncement
  String get timePickerMinuteModeAnnouncement => "";

  @override
  // TODO: implement viewLicensesButtonLabel
  String get viewLicensesButtonLabel => "";
}
