import 'package:flutter/material.dart';

class UIColors {
  static const Color primaryColor = const Color(0xFF5433FF);
  static const Color accentColor = const Color(0xFF20BDFF);

  static const Color triviaAnswerBackgroundColor = const Color(0xFF396afc);
  static const Color triviaAnswerSplashColor = const Color(0xFF2A6BC5);

  static const Color triviaAnswerWrongBackgroundColor = const Color(0xFFDD3E54);
  static const Color triviaAnswerWrongSplashColor = const Color(0xFFCD2E44);

  static const Color triviaAnswerCorrectBackgroundColor = const Color(0xFF11998E);
  static const Color triviaAnswerCorrectSplashColor = const Color(0xFF01897E);

  static const Color triviaTimerBackgroundColor = const Color(0xFFB71C1C);
}

class UITextThemes {
  TextStyle triviaQuestionText = TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.7,
  );

  TextStyle triviaAnswerText = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
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
