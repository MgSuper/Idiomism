part of 'remote_config_bloc.dart';

abstract class RemoteConfigState extends Equatable {
  const RemoteConfigState();

  @override
  List<Object> get props => [];
}

class RemoteConfigInitial extends RemoteConfigState {}

class RemoteConfigLoaded extends RemoteConfigState {
  final int? count;
  const RemoteConfigLoaded({this.count});
}
