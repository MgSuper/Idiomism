import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idiomism/data/model/idiom.dart';
import 'package:idiomism/data/repositories/idiom_repository.dart';
import 'package:idiomism/logic/blocs/idiom/idiom_bloc.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IdiomRepository repository = IdiomRepository();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn'),
        centerTitle: false,
      ),
      body: BlocBuilder<IdiomBloc, IdiomState>(
        builder: (context, state) {
          print(state);
          if (state is IdiomLoading) {
            return Center(
              child: SpinKitDancingSquare(
                color: Colors.red,
                size: 50.0,
              ),
            );
          }
          if (state is IdiomLoaded) {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: state.idioms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.idioms[index].phrase),
                );
              },
            );
          }
          return Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
