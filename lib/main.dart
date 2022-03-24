import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idiomism/data/repositories/idiom_repository.dart';
import 'package:idiomism/logic/blocs/idiom/idiom_bloc.dart';
import 'package:idiomism/logic/blocs/remote_config/remote_config_bloc.dart';
import 'package:idiomism/presentation/router/app_router.dart';
import 'package:idiomism/util/helpers/remote_config.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseRemoteConfig remoteConfig = await RemoteConfiguration.initConfig();
  remoteConfig.fetchAndActivate();

  runApp(MyApp(remoteConfig: remoteConfig));
}

class MyApp extends StatelessWidget {
  final FirebaseRemoteConfig? remoteConfig;

  MyApp({Key? key, @required this.remoteConfig}) : super(key: key);

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => IdiomBloc(
            idiomRepository: IdiomRepository(),
          )..add(LoadIdioms()),
        ),
        BlocProvider(
          create: (_) => RemoteConfigBloc(remoteConfig: remoteConfig!),
        )
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Idiomism',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: _appRouter.onGeneratedRoute,
        );
      }),
    );
  }
}
