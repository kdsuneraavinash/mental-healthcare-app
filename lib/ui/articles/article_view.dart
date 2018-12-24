import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;

class ArticleView extends StatelessWidget {
  final String title;
  final String url;

  ArticleView(this.title, this.url);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton.icon(
            color: theme.UIColors.articleColor,
            icon: Icon(FontAwesomeIcons.backward,
                color: theme.UITextThemes().articleHeaderText.color),
            label: Text(
              "Back",
              style: theme.UITextThemes().articleHeaderText,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      url: url,
      scrollBar: true,
      initialChild: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(theme.UIColors.articleColor),
        ),
      ),
    );
  }
}
