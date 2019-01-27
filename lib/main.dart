import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // The root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme.UITheme.build(), home: HomePage());
  }
}
