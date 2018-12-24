import 'package:flutter/material.dart';

class UIColors {
  static const Color primaryColor = const Color(0xFF5433FF);
  static const Color accentColor = const Color(0xFF20BDFF);

  static const Color homeGridFooterBackgroundColor = Colors.black;
  static const Color homeGridFooterTextColor = Colors.white;
  static const Color homeGridIconColor = Colors.white;

  static const Color triviaColor = Colors.deepOrange;
  static const Color triviaAnswerBackgroundColor = const Color(0xFF2c3e50);
  static const Color triviaAnswerSplashColor = const Color(0xFF2A6BC5);
  static const Color triviaAnswerWrongBackgroundColor = const Color(0xFFDD3E54);
  static const Color triviaAnswerWrongSplashColor = const Color(0xFFCD2E44);
  static const Color triviaAnswerCorrectBackgroundColor =
      const Color(0xFF11998E);
  static const Color triviaAnswerCorrectSplashColor = const Color(0xFF01897E);
  static const Color triviaTimerBackgroundColor = const Color(0xFFB71C1C);
  static const Color triviaLoadingBackgroundColor = const Color(0xFFFEFEFE);
  static const Color triviaLoadingSpinnerColor = const Color(0xFF4e4376);

  static const Color clinicColor = Colors.brown;
  static const Color clinicFabColor = const Color(0xFF2c3e50);
  static const Color clinicFabIconColor = Colors.white;
  static const Color clinicOverlayTextColor = Colors.white;
  static const Color clinicOverlayColor = Color(0xDD000000);

  static const Color doctorColor = Colors.green;
  static const Color doctorCallColor = Colors.green;
  static const Color doctorMessageColor = Colors.orange;
  static const Color doctorEmailColor = Colors.red;
  static const Color doctorDisabledColor = Colors.grey;
  static const Color doctorAvatarMaleColor = const Color(0xFF1565C0);
  static const Color doctorAvatarFemaleColor = Colors.pink;
  static const Color doctorAvatarIconColor = Colors.white;

  static const Color articleColor = Colors.red;
  static const Color articlesOverlayColor = Colors.black;
  static const Color articlesHeaderColor = Color(0xFF455A64);
}

class UITextThemes {
  TextStyle triviaQuestionText = TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.7,
  );

  TextStyle triviaAnswerText = TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );

  TextStyle introScreenTitleText = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.0,
  );

  TextStyle introScreenDataText = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  TextStyle doctorNameText = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontSize: 16.0,
  );

  TextStyle doctorInstituteText = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
  );

  TextStyle articleTopBarBackgroundText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    letterSpacing: 1.0,
  );

  TextStyle articleHeaderText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
}

class UITheme {
  static ThemeData build() {
    return ThemeData(
      primaryColor: UIColors.primaryColor,
      accentColor: UIColors.accentColor,
    );
  }
}
