import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:idiomism/data/model/ads_click_count.dart';
import 'package:idiomism/data/model/flash_card.dart';
import 'package:idiomism/data/repositories/idiom_repository.dart';
import 'package:idiomism/logic/blocs/idiom/idiom_bloc.dart';
import 'package:idiomism/logic/blocs/remote_config/remote_config_bloc.dart';
import 'package:idiomism/presentation/router/app_router.dart';
import 'package:idiomism/util/helpers/remote_config.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(AdsClickCountAdapter());
  Hive.registerAdapter(FlashCardAdapter());
  await Hive.openBox<AdsClickCount>('adsclickcount');
  await Hive.openBox<FlashCard>('flashcards');
  FirebaseRemoteConfig remoteConfig = await RemoteConfiguration.initConfig();

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
          create: (_) => RemoteConfigBloc(
            remoteConfig: remoteConfig,
          )..add(LoadConfig()), // LoadConfig as soon as the app load
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
