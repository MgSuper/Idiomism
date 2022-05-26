import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:theidioms/data/model/idiom.dart';
import 'package:theidioms/logic/blocs/idiom/idiom_bloc.dart';
import 'package:theidioms/presentation/screens/quiz/result_screen.dart';
import 'package:theidioms/presentation/widgets/dragtarget_widget.dart';
import 'package:theidioms/presentation/widgets/quiz_item_widget.dart';
import 'package:theidioms/util/constants.dart';

class QuizScreen extends StatefulWidget {
  static const String id = '/quiz';
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(Random().nextInt(length));
}

class _QuizScreenState extends State<QuizScreen> {
  Idiom? targetQuestion;
  List<Idiom> mixedAnswers = [];
  List<Idiom>? idioms;

  List<Icon> scoreKeeper = [];

  int maxQuestion = 10;

  int correctCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var state = BlocProvider.of<IdiomBloc>(context, listen: true).state;
    if (state is IdiomLoaded) {
      setState(() {
        idioms = state.idioms;
        getTargetQuestion();
        getMixedAnswers();
      });
    }
  }

  getTargetQuestion() {
    setState(() {
      targetQuestion = idioms!.getRandomElement();
    });
  }

  getMixedAnswers() {
    setState(() {
      while (mixedAnswers.length < 2) {
        Idiom tempIdiom = idioms!.getRandomElement();
        if (tempIdiom.phrase != targetQuestion!.phrase) {
          mixedAnswers.add(tempIdiom);
        }
      }
      mixedAnswers.add(targetQuestion!);
      mixedAnswers.shuffle();
    });
  }

  void checkAnswer({required String userAnswer}) {
    if (userAnswer == targetQuestion!.meaning) {
      correctCount++;
      scoreKeeper.add(const Icon(
        Icons.check,
        color: Colors.green,
        size: 30,
      ));
    } else {
      scoreKeeper.add(const Icon(
        Icons.close,
        color: Colors.red,
        size: 30,
      ));
    }
    if (maxQuestion > 0) {
      setState(() {
        mixedAnswers = [];
        getTargetQuestion();
        getMixedAnswers();
        maxQuestion--;
      });
    } else {
      Navigator.pushNamed(context, ResultScreen.id, arguments: correctCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: BlocBuilder<IdiomBloc, IdiomState>(builder: (context, state) {
          if (state is IdiomLoading) {
            return const Center(
              child: SpinKitDancingSquare(
                color: Colors.black,
                size: 50.0,
              ),
            );
          }
          if (state is IdiomLoaded) {
            return Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Draggable<String>(
                        data: targetQuestion!.phrase,
                        maxSimultaneousDrags: 1,
                        feedback: QuizItem(
                          text: targetQuestion!.phrase,
                          color: kGreenColor,
                        ),
                        childWhenDragging: QuizItem(
                          text: targetQuestion!.phrase,
                          color: kGreenColor,
                        ),
                        child: QuizItem(
                          text: targetQuestion!.phrase,
                          color: kGreenColor,
                        )),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: mixedAnswers
                            .map((item) => DragTargetWidget(
                                  text: item.meaning,
                                  onAccept: (String data) {
                                    checkAnswer(userAnswer: item.meaning);
                                  },
                                ))
                            .toList()),
                  ]),
              const SizedBox(height: 30),
              const Text(
                'Results',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: scoreKeeper,
              )
            ]);
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        }));
  }
}
