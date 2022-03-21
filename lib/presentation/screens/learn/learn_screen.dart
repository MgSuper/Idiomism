import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:idiomism/data/model/idiom.dart';
import 'package:idiomism/data/repositories/idiom_repository.dart';
import 'package:idiomism/logic/blocs/idiom/idiom_bloc.dart';
import 'package:idiomism/presentation/widgets/search_widget.dart';

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
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Learn'),
          centerTitle: false,
        ),
        body: BlocBuilder<IdiomBloc, IdiomState>(builder: (context, state) {
          if (state is IdiomLoading) {
            return const Center(
              child: SpinKitDancingSquare(
                color: Colors.red,
                size: 50.0,
              ),
            );
          }
          if (state is IdiomLoaded) {
            List<Idiom> idioms = state.idioms;
            List<String> phrases = getPhrases(idioms);
            return Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: TypeAhead(
                        suggestionsCallback: (pattern) => phrases
                            .where((item) => item
                                .toLowerCase()
                                .startsWith(pattern.toLowerCase()))
                            .toList())),
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: idioms.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(idioms[index].phrase),
                    );
                  },
                )
              ])
            );
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        }),
      )),
    );
  }

  getPhrases(List<Idiom> idioms) {
    return idioms.map((e) => e.phrase).toList();
  }
}
