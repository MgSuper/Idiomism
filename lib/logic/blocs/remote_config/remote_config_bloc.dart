import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

part 'remote_config_event.dart';
part 'remote_config_state.dart';

class RemoteConfigBloc extends Bloc<RemoteConfigEvent, RemoteConfigState> {
  final FirebaseRemoteConfig remoteConfig;
  RemoteConfigBloc({required this.remoteConfig}) : super(RemoteConfigLoading()) {
    // Register event handler
    on<LoadConfig>(_onLoadConfig);
  }

  // Function Implementation
  void _onLoadConfig(event, emit) {
    int count = remoteConfig.getInt('count');
    emit(RemoteConfigLoaded(count: count));
  }

}
