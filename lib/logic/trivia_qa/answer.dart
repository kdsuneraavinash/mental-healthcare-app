import 'package:html_unescape/html_unescape.dart';

/// Describes answer state
enum AnswerState { UNSELECTED, SELECTED_CORRECT, SELECTED_WRONG }

/// Class to create answer objects.
/// Will hold correctness and whether answer was checked.
class Answer {
  final String text;
  final bool correct;
  bool _checked;

  Answer(text, this.correct) : this.text = HtmlUnescape().convert(text) {
    _checked = false;
  }

  /// Check answer for correctness. This will mark the answer as checked.
  bool checkIfCorrect() {
    _checked = true;
    return correct;
  }

  /// Get current answer state
  AnswerState get state {
    if (!_checked) {
      return AnswerState.UNSELECTED;
    } else if (correct) {
      return AnswerState.SELECTED_CORRECT;
    } else {
      return AnswerState.SELECTED_WRONG;
    }
  }

  @override
  String toString() => this.text;
}
