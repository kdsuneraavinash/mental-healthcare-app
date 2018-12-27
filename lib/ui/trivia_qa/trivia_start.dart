import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/text_intro_screen.dart';
import 'package:mental_healthcare_app/ui/trivia_qa/trivia_qa.dart';

class TriviaStartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextIntroScreen(
      appBarColor: theme.UIColors.primaryColor,
      appBarTitleText: "Trivia Start Page",
      fabColor: theme.UIColors.accentColor,
      pageCall: () => TriviaQA(),
      fabIconColor: Colors.white,
      faqs: <FAQBlock>[
        FAQBlock(
            "What is this Game?",
            "This is a game build with some info about mental"
            "health. You will be givin a multiple choice question"
            " (with 4 answers) to answer. THERE IS NO TIME LIMIT."),
        FAQBlock("What is the purpose of this game?",
            "Increasing the awareness of mental health."),
        FAQBlock("How about the scoring system?",
            "+40 marks per correct answer. -30 per wrong answer."),
        FAQBlock(
            "Is that all?",
            "Yes, for now. But we are hoping to add more "
            "features in future.")
      ],
    );
  }
}
