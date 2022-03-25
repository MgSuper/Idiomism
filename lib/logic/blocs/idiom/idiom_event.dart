part of 'idiom_bloc.dart';

abstract class IdiomEvent extends Equatable {
  const IdiomEvent();

  @override
  List<Object> get props => [];
}

class LoadIdioms extends IdiomEvent {}

class IdiomsLoaded extends IdiomEvent {
  final List<Idiom> idioms;
  IdiomsLoaded(
    this.idioms,
  );
  @override
  List<Object> get props => [idioms];
}
