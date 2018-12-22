import 'package:mental_healthcare_app/logic/trivia_qa/answer.dart';
import 'package:mental_healthcare_app/logic/trivia_qa/question.dart';

import 'package:http/http.dart' as HTTP;
import 'dart:convert' as JSON;

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
