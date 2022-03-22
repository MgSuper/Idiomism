import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:idiomism/data/repositories/idiom_repository.dart';
import 'package:idiomism/logic/blocs/idiom/idiom_bloc.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IdiomRepository repository = IdiomRepository();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF17c3ad), Color(0xFFe1f5fc)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Learn'),
          centerTitle: false,
        ),
        body: BlocBuilder<IdiomBloc, IdiomState>(
          builder: (context, state) {
            if (state is IdiomLoading) {
              return const Center(
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
                    onTap: () {
                      Navigator.pushNamed(context, '/learn_detail',
                          arguments: state.idioms[index]);
                    },
                    title: Text(state.idioms[index].phrase),
                  );
                },
              );
            }
            return const Center(
              child: Text('Something went wrong'),
            );
          },
        ),
      ),
    );
  }
}
