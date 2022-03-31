import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:idiomism/boxes.dart';
import 'package:idiomism/data/model/ads_click_count.dart';
import 'package:idiomism/logic/blocs/remote_config/remote_config_bloc.dart';
import 'package:idiomism/presentation/animations/animations.dart';
import 'package:idiomism/presentation/widgets/card_stack_widget.dart';
import 'package:idiomism/presentation/widgets/card_widget.dart';
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

  final box = Boxes.getClickCount();

  String imageUrl = "amazing.png";

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

    precacheImage(const AssetImage("assets/icons/amazing.png"), context);
    precacheImage(const AssetImage("assets/icons/good_job.png"), context);
    precacheImage(const AssetImage("assets/icons/doing_great.png"), context);
    precacheImage(const AssetImage("assets/icons/good.png"), context);
    precacheImage(const AssetImage("assets/icons/slow_n_steady.png"), context);
    precacheImage(const AssetImage("assets/icons/you_got_this.png"), context);

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
  }

  @override
  void dispose() {
    super.dispose();
    Hive.box('adsclickcount').close();
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
              colors: [kPrimaryColor, kSecondaryColor],
            ),
            color: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SafeArea(
            child: Column(children: [
              Stack(
                children: [
                  Column(
                    children: <Widget>[
                      CardStack(
                        onCardChanged: (url) {
                          setState(() {
                            imageUrl = url;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
              FadeAnimation(
                delay: 1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _cardWidget(
                      'assets/icons/learn.png',
                      'Learn',
                      (){
                        Navigator.pushNamed(context, '/learn');
                      }
                    ),
                    SizedBox(
                      width: 5.0.w,
                    ),
                    _cardWidget(
                      'assets/icons/flash_cards.png',
                      'Flash cards',
                      (){
                        Navigator.pushNamed(context, '/train');
                      }
                    ),
                  ],
                ),
              )
            ]),
          ),
          floatingActionButton:
              BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
            builder: (context, state) {
              if (state is RemoteConfigLoaded && _isRewardedAdReady) {
                if (_count <= state.count) {
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
                      'Quick Learn',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              }
              return Container();
            },
          ),
        ));
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

  Widget _cardWidget(image, text, onTap) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          child: Column(
            children: [
              Image.asset(
                image,
                width: 15.w,
                height: 15.h,
              ),
              Text(
                text,
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
              ),
              SizedBox(
                height: 3.h,
              )
            ],
          ),
        ));
  }
}
