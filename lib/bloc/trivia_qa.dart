import 'dart:async';

import 'package:mental_healthcare_app/logic/trivia_qa.dart';
import 'package:rxdart/subjects.dart';

class TriviaQABLoC {
  TriviaQuestion _lastQuestion;
  int _score;

  // out Streams
  final StreamController<TriviaQuestion> _triviaQuestionStreamController =
      BehaviorSubject();
  Stream<TriviaQuestion> get triviaQuestionStream =>
      _triviaQuestionStreamController.stream;

  final StreamController<int> _scoreStreamController =
      BehaviorSubject(seedValue: 0);
  Stream<int> get scoreStream => _scoreStreamController.stream;

  final StreamController<bool> _loadingStreamController =
      BehaviorSubject(seedValue: true);
  Stream<bool> get loadingStream => _loadingStreamController.stream;

  // in Streams - Sinks
  final ReplaySubject<Answer> _answerSelectedSubject = ReplaySubject();
  Sink<Answer> get answerSelectedSink => _answerSelectedSubject.sink;

  TriviaQABLoC() {
    _score = 0;
    _loadNewQuestion();
    _answerSelectedSubject.listen(_answerSelected);
  }

  void dispose() {
    _triviaQuestionStreamController.close();
    _answerSelectedSubject.close();
    _loadingStreamController.close();
    _scoreStreamController.close();
  }

  void _answerSelected(Answer answer) {
    bool isCorrect = _lastQuestion.isCorrect(answer);
    _triviaQuestionStreamController.add(_lastQuestion);
    if (isCorrect) {
      _score += 40;
      _scoreStreamController.add(_score);
      _loadNewQuestion();
    }else{
      _score -= 30;
    }
    _scoreStreamController.add(_score);
  }

  Future<void> _loadNewQuestion() async {
    _loadingStreamController.add(true);
    do {
      _lastQuestion = await TriviaQuestion.fromOpenDB();
    } while (_lastQuestion == null);
    _triviaQuestionStreamController.add(_lastQuestion);
    _loadingStreamController.add(false);
  }
}
