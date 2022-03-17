part of 'idiom_bloc.dart';

abstract class IdiomEvent extends Equatable {
  const IdiomEvent();

  @override
  List<Object> get props => [];
}

class LoadIdioms extends IdiomEvent {}

class UpdateIdioms extends IdiomEvent {
  final List<Idiom> idioms;
  UpdateIdioms(
    this.idioms,
  );
  @override
  List<Object> get props => [idioms];
}
