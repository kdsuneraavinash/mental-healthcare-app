import 'package:html_unescape/html_unescape.dart';
import 'package:meta/meta.dart';

/// Class to hold the question text
@immutable
class Question {
  final String _text;

  Question(text) : this._text = HtmlUnescape().convert(text);

  @override
  String toString() {
    return this._text;
  }
}
