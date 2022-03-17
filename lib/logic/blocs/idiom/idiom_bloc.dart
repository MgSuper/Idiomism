import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idiomism/data/model/idiom.dart';
import 'package:idiomism/data/repositories/idiom_repository.dart';

part 'idiom_event.dart';
part 'idiom_state.dart';

class IdiomBloc extends Bloc<IdiomEvent, IdiomState> {
  final IdiomRepository _idiomRepository;
  StreamSubscription? _idiomSubscription;

  IdiomBloc({required IdiomRepository idiomRepository})
      : _idiomRepository = idiomRepository,
        super(IdiomLoading()) {
    on<LoadIdioms>(_onLoadIdiom);
    on<UpdateIdioms>(_onUpdateIdiom);
  }

  void _onLoadIdiom(event, Emitter<IdiomState> emit) {
    _idiomSubscription?.cancel();
    _idiomSubscription = _idiomRepository.getAllIdioms().listen(
          (idioms) => add(
            UpdateIdioms(idioms),
          ),
        );
  }

  void _onUpdateIdiom(event, Emitter<IdiomState> emit) {
    emit(IdiomLoaded(idioms: event.idioms));
  }
}
