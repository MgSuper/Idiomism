import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

part 'remote_config_event.dart';
part 'remote_config_state.dart';

class RemoteConfigBloc extends Bloc<RemoteConfigEvent, RemoteConfigState> {
  final FirebaseRemoteConfig _remoteConfig;
  RemoteConfigBloc({required remoteConfig})
      : _remoteConfig = remoteConfig,
        super(RemoteConfigLoading()) {
    // Register event handler
    on<LoadConfig>(_onLoadConfig);
    on<ConfigLoaded>(_onConfigLoaded);
  }

  // Function Implementation
  void _onLoadConfig(event, Emitter<RemoteConfigState> emit) {
    int count = _remoteConfig.getInt('count');
    print('hello 2 ' + count.toString());
    emit(RemoteConfigLoaded(count));
  }

  void _onConfigLoaded(event, Emitter<RemoteConfigState> emit) {
    emit(RemoteConfigLoaded(event.count));
  }
}
