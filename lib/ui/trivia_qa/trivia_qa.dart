import 'package:flutter/material.dart';
import 'package:mental_healthcare_app/bloc/trivia_qa.dart';
import 'package:mental_healthcare_app/logic/trivia_qa.dart';
import 'package:mental_healthcare_app/theme.dart' as theme;

class TriviaQA extends StatelessWidget {
  final TriviaQABLoC bloc;

  TriviaQA() : bloc = TriviaQABLoC();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<int>(
          stream: bloc.scoreStream,
          builder: (_, snapshot) => snapshot.hasData
              ? Text("SCORE ${snapshot.data}")
              : Text("Trivia Questionaire"),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<bool>(
        stream: bloc.loadingStream,
        builder: (_, snapshot) {
          bool isLoading = !snapshot.hasData || snapshot.data;
          List<Widget> widgets = [
            Opacity(
              opacity: 0.7,
              child: Image.network(
                "https://images.pexels.com/photos/40465/pexels-photo-40465.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            TriviaQABody(bloc: bloc),
          ];
          if (isLoading)
            widgets.add(
              Opacity(
                opacity: 0.5,
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(),
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
//        AnimatedTimerLineWidget(),
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

//class AnimatedTimerLineWidget extends StatefulWidget {
//  @override
//  _AnimatedTimerLineWidgetState createState() =>
//      _AnimatedTimerLineWidgetState();
//}
//
//class _AnimatedTimerLineWidgetState extends State<AnimatedTimerLineWidget>
//    with SingleTickerProviderStateMixin {
//  Animation<double> _animation;
//  AnimationController _animationController;
//
//  @override
//  void initState() {
//    super.initState();
//    _animationController = AnimationController(
//        vsync: this,
//        duration: Duration(seconds: 100),
//        animationBehavior: AnimationBehavior.preserve);
//    _animation =
//        CurvedAnimation(parent: _animationController, curve: Curves.linear)
//          ..addStatusListener((status) {
//            if (status == AnimationStatus.completed ||
//                status == AnimationStatus.dismissed) {
//              print("Time is up");
//            }
//          });
//  }
//
//  @override
//  void dispose() {
//    _animationController.stop();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Row(
//      children: <Widget>[
//        Container(
//            width: MediaQuery.of(context).size.width,
//            height: 10.0,
//            child: AnimatedBuilder(
//              animation: _animation,
//              builder: (animation, _) {
//                return LinearProgressIndicator(
//                  value: _animation.value,
//                  valueColor: AlwaysStoppedAnimation(
//                      theme.UIColors.triviaTimerBackgroundColor),
//                );
//              },
//            ))
//      ],
//    );
//  }
//}

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
        margin: EdgeInsets.all(8.0),
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
      opacity: answer.state == AnswerState.SELECTED_WRONG ? 0.0 : 1.0,
      duration: Duration(milliseconds: 750),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: MaterialButton(
          onPressed: dispatcher,
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
