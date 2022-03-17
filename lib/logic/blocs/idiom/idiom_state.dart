part of 'idiom_bloc.dart';

abstract class IdiomState extends Equatable {
  const IdiomState();

  @override
  List<Object> get props => [];
}

class IdiomLoading extends IdiomState {}

class IdiomLoaded extends IdiomState {
  final List<Idiom> idioms;
  IdiomLoaded({
    this.idioms = const <Idiom>[],
  });

  @override
  List<Object> get props => [idioms];
}
