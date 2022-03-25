part of 'remote_config_bloc.dart';

abstract class RemoteConfigEvent extends Equatable {
  const RemoteConfigEvent();

  @override
  List<Object> get props => [];
}

class LoadConfig extends RemoteConfigEvent {}

class ConfigLoaded extends RemoteConfigEvent {
  final int count;
  const ConfigLoaded(this.count);
  @override
  List<Object> get props => [count];
}
