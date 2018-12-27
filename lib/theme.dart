import 'package:flutter/material.dart';

class UIColors {
  static const Color primaryColor = Colors.black;
  static const Color accentColor = Colors.red;
  static const Color iconBackgroundColor = Colors.green;
  static const Color iconSecondaryBackgroundColor = Colors.black;
  static const Color secondaryColor = Colors.teal;
  static const Color avatarIconColor = Colors.white;
  static const Color splashColor = Colors.amber;

  static const Color triviaAnswerBackgroundColor = const Color(0xFF2c3e50);
  static const Color triviaAnswerWrongBackgroundColor = const Color(0xFFDD3E54);
  static const Color triviaAnswerCorrectBackgroundColor =
      const Color(0xFF11998E);

  static const Color doctorCallColor = Colors.green;
  static const Color doctorMessageColor = Colors.orange;
  static const Color doctorEmailColor = Colors.red;
  static const Color doctorDisabledColor = Colors.grey;
}

class UITextThemes {
  TextStyle dialogHeaderText = TextStyle(
    color: Colors.black,
    fontSize: 28,
    fontWeight: FontWeight.w400,
  );

  TextStyle clinicOverlayText = TextStyle(
    color: Colors.white,
  );

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

  TextStyle articleTopBarBackgroundText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    letterSpacing: 1.0,
  );

  TextStyle articleHeaderText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w300,
    fontSize: 18.0,
  );

  TextStyle mainScreenText = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 24.0,
  );
}

class UITheme {
  static ThemeData build() {
    return ThemeData(
        primaryColor: UIColors.primaryColor,
        accentColor: UIColors.accentColor,
        dialogBackgroundColor: Colors.transparent,
        accentColorBrightness: Brightness.light,
        brightness: Brightness.light,
        splashColor: UIColors.splashColor,
        textTheme: TextTheme(
          subtitle: TextStyle(fontFamily: "Open Sans"),
          title: TextStyle(fontFamily: "Open Sans"),
          body1: TextStyle(fontFamily: "Open Sans"),
          body2: TextStyle(fontFamily: "Open Sans"),
          button: TextStyle(fontFamily: "Open Sans"),
          caption: TextStyle(fontFamily: "Open Sans"),
          display1: TextStyle(fontFamily: "Open Sans"),
          display2: TextStyle(fontFamily: "Open Sans"),
          display3: TextStyle(fontFamily: "Open Sans"),
          headline: TextStyle(fontFamily: "Open Sans"),
          overline: TextStyle(fontFamily: "Open Sans"),
          subhead: TextStyle(fontFamily: "Open Sans"),
        ));
  }
}
