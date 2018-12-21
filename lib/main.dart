import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/ui/trivia_qa/trivia_qa.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // The root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental HealthCare',
      theme: theme.UITheme.build(),
      home: TriviaQA()
    );
  }
}