import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

class CustomLocalizationProvider extends InheritedWidget {
  final String locale;
  final CustomLocalization localization;

  CustomLocalizationProvider({key, locale, child})
      : this.locale =
            (locale == 'si') ? locale : (locale == 'ta') ? locale : 'en',
        this.localization =
            (locale == 'si') ? Si() : (locale == 'ta') ? Ta() : En(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(CustomLocalizationProvider oldWidget) {
    return this.locale != oldWidget.locale;
  }

  static CustomLocalizationProvider of(BuildContext context) {
    return context.ancestorWidgetOfExactType(CustomLocalizationProvider);
  }
}

abstract class CustomLocalization {
  String get app_name;
  String get locationsAppBarTitle;
  String get consultantsAppBarTitle;
  String get homePageAppBarLanguageSelected;
  String get homePageAppBarTitle;
  String get homePageCenterScreenText;
  String get homePageDrawerClinics;
  String get homePageDrawerClinicsDescription;
  String get homePageDrawerConsultants;
  String get homePageDrawerConsultantsDescription;
  String get homePageDrawerReadArticles;
  String get homePageDrawerReadArticlesDescription;
  String get homePageRecentArticlesTitle;
  String get postCardReadButtonText;
  String get readArticlesAppBarTitle;
  String get readArticlesArticlesTitle;
  String get readArticlesSubCategoriesTitle;
}

class En implements CustomLocalization {
  const En();

  String get app_name => "Sahanaya App";
  String get locationsAppBarTitle => "Our Locations";
  String get consultantsAppBarTitle =>
      "Consultants & Psychiatrists in Sri Lanka";
  String get homePageAppBarLanguageSelected => "English";
  String get homePageAppBarTitle => "Sahanaya App";
  String get homePageCenterScreenText =>
      "Welcome to Sahanaya App.\nAn information center for mental health issues.";
  String get homePageDrawerClinics => "Our Locations";
  String get homePageDrawerClinicsDescription => "View Our Locations & Adressess";
  String get homePageDrawerConsultants => "About Us";
  String get homePageDrawerConsultantsDescription => "Know about NCMH";
  String get homePageDrawerReadArticles => "Read Articles";
  String get homePageDrawerReadArticlesDescription => "Spread Awareness";
  String get homePageRecentArticlesTitle => "Recent Articles";
  String get postCardReadButtonText => "Read";
  String get readArticlesAppBarTitle => "Read Articles";
  String get readArticlesArticlesTitle => "Read Articles";
  String get readArticlesSubCategoriesTitle => "Sub Categories";
}

class Si implements CustomLocalization {
  const Si();

  String get app_name => "සහනය";
  String get locationsAppBarTitle => "සායන ඇති ස්ථාන";
  String get consultantsAppBarTitle => "ශ්‍රී ලංකාවේ මනෝ වෛද්‍යවරුන්";
  String get homePageAppBarLanguageSelected => "සිංහල";
  String get homePageAppBarTitle => "සහනය";
  String get homePageCenterScreenText =>
      "සහනය App එකට සාදරයෙන් පිලිගනිමු..\nමෙය ශ්‍රී ලංකාවේ මානසික සෞඛ්‍යය පිලිබඳව ඇති තොරතුරු මධ්‍යස්ථානයකි.";
  String get homePageDrawerClinics => "සායන ඇති ස්ථාන";
  String get homePageDrawerClinicsDescription => null;
  String get homePageDrawerConsultants => "මනෝ වෛද්‍යවරුන් හා උපදේශකවරුන්";
  String get homePageDrawerConsultantsDescription =>
      null;
  String get homePageDrawerReadArticles => "ලිපි කියවන්න";
  String get homePageDrawerReadArticlesDescription =>
      "මානසික ගැටළු පිලිබදව දැනුවත් වෙන්න";
  String get homePageRecentArticlesTitle => "මෑතකාලීන ලිපි";
  String get postCardReadButtonText => "කියවන්න";
  String get readArticlesAppBarTitle => "ලිපි කියවන්න";
  String get readArticlesArticlesTitle => "ලිපි කියවන්න";
  String get readArticlesSubCategoriesTitle => "අනු ප්‍රවර්ගය";
}

class Ta implements CustomLocalization {
  const Ta();

  String get app_name => "சஹனய";
  String get locationsAppBarTitle => "மருத்துவ இடங்கள்";
  String get consultantsAppBarTitle =>
      "இலங்கையில் ஆலோசகர்கள் மற்றும் உளவியலாளர்கள்";
  String get homePageAppBarLanguageSelected => "தமிழ்";
  String get homePageAppBarTitle => "சஹனய";
  String get homePageCenterScreenText =>
      "சஹனய App க்கு வரவேற்கிறோம்..\nஇது மனநல பிரச்சினைகளுக்கு ஒரு தகவல் மையமாகும்.";
  String get homePageDrawerClinics => "மருத்துவ இடங்கள்";
  String get homePageDrawerClinicsDescription => "மன நல மருத்துவங்கள் காண்க";
  String get homePageDrawerConsultants => "ஆலோசகர்கள் மற்றும் உளவியலாளர்கள்";
  String get homePageDrawerConsultantsDescription => "தொடர்பு ஆலோசகர்கள்";
  String get homePageDrawerReadArticles => "கட்டுரைகள் படிக்கவும்";
  String get homePageDrawerReadArticlesDescription => "விழிப்புணர்வு";
  String get homePageRecentArticlesTitle => "சமீபத்திய கட்டுரைகள்";
  String get postCardReadButtonText => "படிக்க";
  String get readArticlesAppBarTitle => "கட்டுரைகள் படிக்கவும்";
  String get readArticlesArticlesTitle => "கட்டுரைகள் படிக்கவும்";
  String get readArticlesSubCategoriesTitle => "துணை வகைகள்";
}
