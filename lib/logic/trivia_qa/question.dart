import 'package:html_unescape/html_unescape.dart';
import 'package:meta/meta.dart';

/// Class to hold the question text
@immutable
class Question {
  final String text;

  Question(text) : this.text = HtmlUnescape().convert(text);

  @override
  String toString() {
    return this.text;
  }
}
