import 'package:flutter/material.dart';
class UITheme {
  static ThemeData build() {
    return ThemeData( 
      primaryColor: Color(0xff2B3A67),
      accentColor: Color(0xffE84855),
      dialogBackgroundColor: Colors.transparent,
      accentColorBrightness: Brightness.light,
      brightness: Brightness.light,
    );
  }
}
