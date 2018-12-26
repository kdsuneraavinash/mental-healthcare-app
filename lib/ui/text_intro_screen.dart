import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:mental_healthcare_app/ui/transition_maker.dart';

class FAQBlock {
  final String faqQuestion;
  final String faqAnswer;

  FAQBlock(this.faqQuestion, this.faqAnswer);
}

class TextIntroScreen extends StatelessWidget {
  final String appBarTitleText;
  final Color appBarColor;
  final List<FAQBlock> faqs;
  final Color fabColor;
  final Color fabIconColor;
  final VoidCallback pageCall;

  TextIntroScreen({
    @required this.appBarTitleText,
    @required this.faqs,
    @required this.fabIconColor,
    @required this.pageCall,
    this.fabColor,
    this.appBarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitleText),
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: ListView(
          children: faqs
              .map(
                (v) => Column(
                      children: <Widget>[
                        _buildTitle(v.faqQuestion),
                        _buildData(v.faqAnswer),
                      ],
                    ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TransitionMaker.fadeTransition(destinationPageCall: pageCall)
            ..startReplacePush(context);
        },
        child: Icon(
          FontAwesomeIcons.play,
          color: fabIconColor,
        ),
        backgroundColor: fabColor,
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: theme.UITextThemes().introScreenTitleText,
      ),
    );
  }

  Widget _buildData(String text) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: theme.UITextThemes().introScreenDataText,
      ),
    );
  }
}
