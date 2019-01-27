import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';

class ArticleView extends StatefulWidget {
  final String title;
  final String url;
  final FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();

  ArticleView(this.title, this.url);

  @override
  ArticleViewState createState() {
    return new ArticleViewState();
  }
}

class ArticleViewState extends State<ArticleView> {
  bool _finishedLoad = false;

  @override
  void initState() {
    widget.flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        widget.flutterWebViewPlugin.evalJavascript("""
      document.getElementsByClassName('navbar')[0].style.display = 'none';
      document.getElementsByClassName('section-blog-info')[0].style.display = 'none';
      document.getElementsByClassName('blog-sidebar')[0].style.display = 'none';
      document.getElementsByClassName('footer-wrapper')[0].style.display = 'none';
      document.getElementsByClassName('related-posts')[0].style.display = 'none';
      """);
        setState(() {
          _finishedLoad = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WebviewScaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Theme.of(context).primaryColor,
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 40.0),
                alignment: Alignment.center,
                child: !_finishedLoad
                    ? SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                        width: 30.0,
                        height: 30.0,
                      )
                    : null,
              ),
            ],
          ),
          url: widget.url,
          scrollBar: true,
          initialChild: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
            ),
          ),
        ),
      ],
    );
  }
}
