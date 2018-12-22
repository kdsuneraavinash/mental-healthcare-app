import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/ui/doc_list/doc_list_page.dart';
import 'package:mental_healthcare_app/ui/transition_maker.dart';
import 'package:mental_healthcare_app/ui/trivia_qa/trivia_qa.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Mental Health Care App"),),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            IconGridTile(
              footerText: "Send us your problem",
              color: Colors.blue,
              icon: FontAwesomeIcons.envelopeOpen,
            ),
            IconGridTile(
              footerText: "Consultants & Psychiatrists in Sri Lanka",
              color: theme.UIColors.doctorListColor,
              icon: FontAwesomeIcons.stethoscope,
              destinationPageCall: () {
                TransitionMaker.slideTransition(
                    destinationPageCall: () => DocListPage())
                  ..start(context);
              },
            ),
            IconGridTile(
              footerText: "Read Articles on mental health",
              color: Colors.red,
              icon: FontAwesomeIcons.newspaper,
            ),
            IconGridTile(
              footerText: "Trivia Questions on Mental Health",
              color: theme.UIColors.triviaColor,
              icon: FontAwesomeIcons.question,
              destinationPageCall: () {
                TransitionMaker.slideTransition(
                    destinationPageCall: () => TriviaQA())
                  ..start(context);
              },
            )
          ],
        ));
  }
}

class IconGridTile extends StatelessWidget {
  final String footerText;
  final Color color;
  final IconData icon;
  final VoidCallback destinationPageCall;

  IconGridTile(
      {@required this.footerText,
      @required this.color,
      @required this.icon,
      this.destinationPageCall});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: destinationPageCall,
        child: GridTile(
          child: Container(
            color: color,
            child: Icon(
              icon,
              size: MediaQuery.of(context).size.width / 5,
              color: theme.UIColors.homeGridIconColor,
            ),
          ),
          footer: Opacity(
            opacity: 0.8,
            child: Container(
              color: theme.UIColors.homeGridFooterBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  footerText,
                  style: TextStyle(color: theme.UIColors.homeGridFooterTextColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
