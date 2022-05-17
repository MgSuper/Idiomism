import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:theidioms/data/model/idiom.dart';
import 'package:theidioms/logic/blocs/idiom/idiom_bloc.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(Random().nextInt(length));
}

class _QuizScreenState extends State<QuizScreen> {
  Idiom? targetQuestion;
  List<Idiom>? mixedAnswers;
  List<Idiom>? idioms;

  @override
  void initState() {
    var state = context.read<IdiomBloc>().state;
    if (state is IdiomLoaded) {
      idioms = state.idioms;
      getTargetQuestion();
      getMixedAnswers();
    }
    super.initState();
  }

  getTargetQuestion() {
    print(idioms!.getRandomElement());
  }

  getMixedAnswers() {

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
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.blue,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.yellow,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.green,
                      ),
                    ],
                  )
                ]);
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        }));
  }
}
