import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idiomism/data/model/idiom.dart';
import 'package:idiomism/data/repositories/idiom_repository.dart';

part 'idiom_event.dart';
part 'idiom_state.dart';

class IdiomBloc extends Bloc<IdiomEvent, IdiomState> {
  final IdiomRepository idiomRepository;

  IdiomBloc({required this.idiomRepository}) : super(IdiomLoading()) {
    on<LoadIdioms>(_onLoadIdiom);
    on<IdiomsLoaded>(_onIdiomLoaded);
  }

  void _onLoadIdiom(event, Emitter<IdiomState> emit) {
    idiomRepository.getAllIdioms().listen(
          (idioms) => add(
            IdiomsLoaded(idioms),
          ),
        );
  }

  void _onIdiomLoaded(event, Emitter<IdiomState> emit) {
    emit(IdiomLoaded(idioms: event.idioms));
  }
}
