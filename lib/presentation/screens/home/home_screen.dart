import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:idiomism/boxes.dart';
import 'package:idiomism/data/model/ads_click_count.dart';
import 'package:idiomism/logic/blocs/remote_config/remote_config_bloc.dart';
import 'package:idiomism/presentation/animations/animations.dart';
import 'package:idiomism/presentation/widgets/icon_widget.dart';
import 'package:idiomism/util/ad_helper.dart';
import 'package:idiomism/util/constants.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  late RewardedAd _rewardedAd;
  bool _isRewardedAdReady = false;

  int _count = 0;
  int _remoteConfigCount = 0;

  final box = Boxes.getClickCount();

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
    _loadRewardedAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      _count = _getCount();
    } catch (e) {
      DateTime today = _getCurrentDate();
      AdsClickCount adsClickCount = AdsClickCount()
        ..count = 0
        ..date = today;
      box.add(adsClickCount);
      _count = _getCount();
    }

    final state =
        BlocProvider.of<RemoteConfigBloc>(context, listen: true).state;
    print('state ${state}');
    if (state is RemoteConfigLoaded) {
      setState(() {
        _remoteConfigCount = state.count;
        print('hello ' + _count.toString());
        print('hello 1 ' + _remoteConfigCount.toString());
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
    _bannerAd.dispose();
    _rewardedAd.dispose();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                _isRewardedAdReady = false;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _isRewardedAdReady = true;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
          setState(() {
            _isRewardedAdReady = false;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF17c3ad), Color(0xFFe1f5fc)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Home'),
        ),
        body: FadeAnimation(
          delay: 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                    height: 30.0.h,
                    width: 100.0.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFc5bbf9),
                          Color(0xFFb9eef5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Efficiency',
                          style: TextStyle(
                            color: const Color(0xFF0654b1),
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 2.0.h,
                        ),
                        CircularStepProgressIndicator(
                          totalSteps: 100,
                          currentStep: 72,
                          selectedColor: const Color(0xFF17c3ad),
                          unselectedColor: Colors.white,
                          padding: 0,
                          width: 40.0.w,
                          height: 20.0.h,
                          child: const Icon(
                            Icons.tag_faces,
                            color: Color(0xFF0654b1),
                            size: 84,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconWidget(
                      title: 'Learn',
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/learn');
                        },
                        icon: Image.asset(
                          'assets/icons/learn.png',
                        ),
                      ),
                      color: Colors.white,
                      delayanimation: 1.5,
                    ),
                    SizedBox(
                      width: 4.0.w,
                    ),
                    IconWidget(
                      title: 'Flash Cards',
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/flash_cards.png',
                        ),
                      ),
                      color: Colors.white,
                      delayanimation: 1.7,
                    ),
                    SizedBox(
                      width: 4.0.w,
                    ),
                    IconWidget(
                      title: 'Exam',
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/exam.png',
                        ),
                      ),
                      color: Colors.white,
                      delayanimation: 1.9,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _isBannerAdReady
            ? Container(
                height: 10.0.h,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                ),
              )
            : null,
        floatingActionButton: BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
          builder: (context, state) {
            print('state inside ${state}');
            print('_isRewardedAdReady inside ${_isRewardedAdReady}');
            print('_count inside ${_count}');
            if (state is RemoteConfigLoaded && _isRewardedAdReady) {
              if (_count <= state.count) {
                print('state.count ${state.count}');
                return FloatingActionButton.extended(
                  onPressed: () {
                    _rewardedAd.show(onUserEarnedReward: (ad, reward) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    _updateCount();
                    setState(() {
                      _count = _getCount();
                    });
                  },
                  label: const Text(
                    'Learn',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.add,
                    color: Colors.amberAccent[400],
                  ),
                );
              }
            }
            return Container();
          },
        ),
        // _isRewardedAdReady
        //     ? FloatingActionButton.extended(
        //         onPressed: () {
        //           if (_count <= _remoteConfigCount) {
        //             _rewardedAd.show(onUserEarnedReward: (ad, reward) {
        //               ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //             });
        //             _updateCount();
        //             setState(() {
        //               _count = _getCount();
        //             });
        //           }
        //         },
        //         label: const Text(
        //           'get reward',
        //           style: TextStyle(color: Colors.white),
        //         ),
        //         icon: Icon(
        //           Icons.add,
        //           color: Colors.amberAccent[400],
        //         ),
        //       )
        //     : null,
      ),
    );
  }

  _getCount() {
    return box.getAt(0)?.count ?? 0;
  }

  _updateCount() {
    DateTime today = _getCurrentDate();
    int boxCount = box.getAt(0)?.count ?? 0;
    DateTime boxDate = box.getAt(0)?.date ?? today;

    AdsClickCount adsClickCount;
    if (boxDate == today) {
      adsClickCount = AdsClickCount()
        ..count = ++boxCount
        ..date = boxDate;
    } else {
      adsClickCount = AdsClickCount()
        ..count = 0
        ..date = today;
    }
    box.putAt(0, adsClickCount);
  }

  _getCurrentDate() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    return today;
  }
}


// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFF17c3ad), Color(0xFFe1f5fc)],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: Text('Home'),
//         ),
//         body: FadeAnimation(
//           delay: 1.5,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 2.0.w),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25)),
//                   child: Container(
//                     height: 30.0.h,
//                     width: 100.0.w,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Color(0xFFc5bbf9),
//                           Color(0xFFb9eef5),
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomCenter,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           blurRadius: 7,
//                           offset: const Offset(0, 3),
//                         )
//                       ],
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           'Efficiency',
//                           style: TextStyle(
//                             color: Color(0xFF0654b1),
//                             fontSize: 18.0.sp,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         CircularStepProgressIndicator(
//                           totalSteps: 100,
//                           currentStep: 72,
//                           selectedColor: Color(0xFF17c3ad),
//                           unselectedColor: Colors.white,
//                           padding: 0,
//                           width: 40.0.w,
//                           height: 20.0.h,
//                           child: Icon(
//                             Icons.tag_faces,
//                             color: Color(0xFF0654b1),
//                             size: 84,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 2.0.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 3.0.w),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     IconWidget(
//                       title: 'Learn',
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/learn');
//                         },
//                         icon: Image.asset(
//                           'assets/icons/learn.png',
//                         ),
//                       ),
//                       color: Colors.white,
//                       delayanimation: 1.5,
//                     ),
//                     SizedBox(
//                       width: 4.0.w,
//                     ),
//                     IconWidget(
//                       title: 'Flash Cards',
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: Image.asset(
//                           'assets/icons/flash_cards.png',
//                         ),
//                       ),
//                       color: Colors.white,
//                       delayanimation: 1.7,
//                     ),
//                     SizedBox(
//                       width: 4.0.w,
//                     ),
//                     IconWidget(
//                       title: 'Exam',
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: Image.asset(
//                           'assets/icons/exam.png',
//                         ),
//                       ),
//                       color: Colors.white,
//                       delayanimation: 1.9,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
