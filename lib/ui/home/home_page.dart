import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return _buildUnderConstruction();
  }

  Widget _buildFeaturedCard(double width, int index) {
    List<Widget> widgets = [
      Container(
        width: width / 2.5,
        height: 250.0,
        decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              image: AssetImage("assets/article-reader.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(0xaa),
                BlendMode.srcATop,
              )),
        ),
      ),
      Expanded(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Title",
              style: TextStyle(fontSize: 32.0),
            ),
            Text(
              "Title",
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      )),
    ];

    if (index % 2 == 0) widgets = widgets.reversed.toList();

    return Card(
      child: Row(
        children: widgets,
      ),
    );
  }

  Widget _buildUnderConstruction() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Icon(
            FontAwesomeIcons.cog,
            size: 64.0,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Under Construction",
              style: theme.UITextThemes().mainScreenText,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
