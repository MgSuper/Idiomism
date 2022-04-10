import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:theidioms/data/model/ads_click_count.dart';
import 'package:theidioms/data/model/flash_card.dart';
import 'package:theidioms/data/model/interstitial_click_count.dart';
import 'package:theidioms/data/repositories/idiom_repository.dart';
import 'package:theidioms/logic/blocs/idiom/idiom_bloc.dart';
import 'package:theidioms/logic/blocs/remote_config/remote_config_bloc.dart';
import 'package:theidioms/presentation/router/app_router.dart';
import 'package:theidioms/util/helpers/remote_config.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await MobileAds.instance.initialize().then((InitializationStatus status) {
    MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(
          tagForChildDirectedTreatment:
              TagForChildDirectedTreatment.unspecified,
          testDeviceIds: <String>[
            'F8530ED7C8BED2E8D745436D152CB7ED',
            'F24CA548F6A78A6AC67B649EC3CAEC2A'
          ]),
    );
  });
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(AdsClickCountAdapter());
  Hive.registerAdapter(FlashCardAdapter());
  Hive.registerAdapter(InterstitialClickCountAdapter());
  await Hive.openBox<AdsClickCount>('adsclickcount');
  await Hive.openBox<FlashCard>('flashcards');
  await Hive.openBox<InterstitialClickCount>('interstitialCount');
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
          title: 'theidioms',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Kollektif',
          ),
          onGenerateRoute: _appRouter.onGeneratedRoute,
        );
      }),
    );
  }
}
