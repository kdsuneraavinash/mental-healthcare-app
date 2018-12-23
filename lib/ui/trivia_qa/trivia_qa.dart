import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/bloc/trivia_qa_bloc.dart';
import 'package:mental_healthcare_app/logic/trivia_qa/answer.dart';
import 'package:mental_healthcare_app/logic/trivia_qa/trivia_question.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;

class TriviaQA extends StatelessWidget {
  final TriviaQABLoC bloc;

  TriviaQA() : bloc = TriviaQABLoC();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("TriviaPage"),
      appBar: AppBar(
        backgroundColor: theme.UIColors.triviaColor,
        title: StreamBuilder<int>(
          stream: bloc.scoreStream,
          builder: (_, snapshot) => snapshot.hasData
              ? Text("SCORE: ${snapshot.data}")
              : Text("Trivia Questionaire"),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<bool>(
        stream: bloc.loadingStream,
        builder: (_, snapshot) {
          bool isLoading = !snapshot.hasData || snapshot.data;
          List<Widget> widgets = [
            TriviaQABody(bloc: bloc),
          ];
          if (isLoading)
            widgets.add(
              Opacity(
                opacity: 0.5,
                child: Container(
                  color: theme.UIColors.triviaLoadingBackgroundColor,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        theme.UIColors.triviaLoadingSpinnerColor,
                      ),
                    ),
                  ),
                ),
              ),
            );
          return Stack(
            fit: StackFit.expand,
            children: widgets,
          );
        },
      ),
    );
  }
}

class TriviaQABody extends StatelessWidget {
  final TriviaQABLoC bloc;
  TriviaQABody({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
            child: StreamBuilder<TriviaQuestion>(
          stream: bloc.triviaQuestionStream,
          builder: (_, snapshot) => snapshot.hasData
              ? QuestionWidget(
                  text: snapshot.data.question.toString(),
                )
              : Container(),
        )),
        StreamBuilder<TriviaQuestion>(
          stream: bloc.triviaQuestionStream,
          builder: (_, snapshot) => snapshot.hasData
              ? _buildAnswerButtons(snapshot.data, bloc.answerSelectedSink)
              : Container(),
        ),
      ],
    );
  }

  Widget _buildAnswerButtons(TriviaQuestion triviaQuestion, Sink<Answer> sink) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [0, 1, 2, 3]
          .map(
            (index) => AnswerWidget(
                  answer: triviaQuestion.answers[index],
                  dispatcher: () => sink.add(triviaQuestion.answers[index]),
                ),
          )
          .toList(),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final String text;

  QuestionWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        padding: EdgeInsets.all(8.0),
        child: Align(
          child: Text(
            text,
            style: theme.UITextThemes().triviaQuestionText,
            textAlign: TextAlign.center,
            overflow: TextOverflow.fade,
          ),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

class AnswerWidget extends StatelessWidget {
  final Answer answer;
  final VoidCallback dispatcher;

  AnswerWidget({@required this.answer, @required this.dispatcher});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: answer.state == AnswerState.SELECTED_WRONG ? 0.6 : 1.0,
      duration: Duration(milliseconds: 750),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: MaterialButton(
          clipBehavior: Clip.hardEdge,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(32.0)),
          ),
          onPressed:
              answer.state == AnswerState.SELECTED_WRONG ? null : dispatcher,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              answer.toString(),
              style: theme.UITextThemes().triviaAnswerText,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
            width: double.infinity,
          ),
          color: answer.state == AnswerState.SELECTED_CORRECT
              ? theme.UIColors.triviaAnswerCorrectBackgroundColor
              : answer.state == AnswerState.SELECTED_WRONG
                  ? theme.UIColors.triviaAnswerWrongBackgroundColor
                  : theme.UIColors.triviaAnswerBackgroundColor,
          splashColor: answer.state == AnswerState.SELECTED_CORRECT
              ? theme.UIColors.triviaAnswerCorrectSplashColor
              : answer.state == AnswerState.SELECTED_WRONG
                  ? theme.UIColors.triviaAnswerWrongSplashColor
                  : theme.UIColors.triviaAnswerSplashColor,
          padding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
