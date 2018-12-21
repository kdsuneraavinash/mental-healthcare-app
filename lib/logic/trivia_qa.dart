import 'package:http/http.dart' as HTTP;
import 'dart:convert' as JSON;

import 'package:meta/meta.dart';
import 'package:html_unescape/html_unescape.dart';

/// Class which provides TriviaQuestion objects.
/// Provides implementation to hold questions and answers.
/// Can use [fromOpenDB()] to get a question using Open DB API.
/// Correct answer is not visible and is available only through [isCorrect()]
/// method.
class TriviaQuestion {
  final Question _question;
  final List<Answer> _answers;
  int _attempts;

  /// get question object
  Question get question => this._question;

  /// get answer object
  List<Answer> get answers => this._answers;

  /// Get number of attempts
  int get attempts => this._attempts;

  /// check whether the answer is correct.
  /// Not that this will mark the answer as checked.
  bool isCorrect(Answer answer) {
    _attempts++;
    return answer.checkIfCorrect();
  }

  TriviaQuestion(this._question, this._answers) {
    _attempts = 0;
  }

  /// Get question from API and parse it.
  /// If parsing failed this will return null.
  static Future<TriviaQuestion> fromOpenDB() async {
    Map<String, dynamic> json = await getQuestionFromOpenDB();
    try {
      // Parse question
      Question question = Question(json['question']);

      // Parse wrong answers
      List<Answer> answers = json['incorrect_answers']
          .map<Answer>((v) => Answer(v.toString(), false))
          .toList();
      // Parse ans add correct answer
      Answer correctAnswer = Answer(json['correct_answer'], true);
      answers.add(correctAnswer);
      // Shuffle answers to get randomness
      answers.shuffle();

      return TriviaQuestion(question, answers);
    } catch (_) {
      return null;
    }
  }

  /// Gets a question from Open DB.
  /// Errors will not be handled inside.
  /// On an error this will return an empty Map.
  static Future<Map<String, dynamic>> getQuestionFromOpenDB() async {
    HTTP.Response response = await HTTP
        .get("https://opentdb.com/api.php?amount=1&type=multiple")
        .catchError((_) => null);

    // return empty map on error
    if (response == null) return {};

    // Parse and return Map
    Map<String, dynamic> jsonResponse = JSON.jsonDecode(response.body);
    return jsonResponse['results'][0];
  }

  @override
  String toString() => "$question:\n"
      "\t 1. ${answers[0]}\n"
      "\t 2. ${answers[1]}\n"
      "\t 3. ${answers[2]}\n"
      "\t 4. ${answers[3]}\n";
}

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

/// Describes answer state
enum AnswerState { UNSELECTED, SELECTED_CORRECT, SELECTED_WRONG }

/// Class to create answer objects.
/// Will hold correctness and whether answer was checked.
class Answer {
  final String _text;
  final bool _correct;
  bool _checked;

  Answer(text, this._correct) : this._text = HtmlUnescape().convert(text) {
    _checked = false;
  }

  /// Check answer for correctness. This will mark the answer as checked.
  bool checkIfCorrect() {
    _checked = true;
    return _correct;
  }

  /// Get current answer state
  AnswerState get state {
    if (!_checked) {
      return AnswerState.UNSELECTED;
    } else if (_correct) {
      return AnswerState.SELECTED_CORRECT;
    } else {
      return AnswerState.SELECTED_WRONG;
    }
  }

  @override
  String toString() => this._text;
}
