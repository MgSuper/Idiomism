import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

part 'remote_config_event.dart';
part 'remote_config_state.dart';

class RemoteConfigBloc extends Bloc<RemoteConfigEvent, RemoteConfigState> {
  final FirebaseRemoteConfig remoteConfig;
  RemoteConfigBloc({required this.remoteConfig})
      : super(RemoteConfigLoading()) {
    // Register event handler
    on<LoadConfig>(_onLoadConfig);
    on<UpdateConfig>(_onUpdateConfig);
  }

  // Function Implementation
  void _onLoadConfig(event, Emitter<RemoteConfigState> emit) {
    int count = remoteConfig.getInt('count');
    print('hello 2 ' + count.toString());
    UpdateConfig(count);
  }

  void _onUpdateConfig(event, Emitter<RemoteConfigState> emit) {
    emit(RemoteConfigLoaded(event.count));
  }
}
