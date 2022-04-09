import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:theidioms/boxes.dart';
import 'package:theidioms/data/model/ads_click_count.dart';
import 'package:theidioms/data/model/idiom.dart';
import 'package:theidioms/logic/blocs/idiom/idiom_bloc.dart';
import 'package:theidioms/logic/blocs/remote_config/remote_config_bloc.dart';
import 'package:theidioms/presentation/animations/animations.dart';
import 'package:theidioms/presentation/widgets/card_stack_widget.dart';
import 'package:theidioms/presentation/widgets/card_widget.dart';
import 'package:theidioms/util/ad_helper.dart';
import 'package:theidioms/util/constants.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RewardedAd _rewardedAd;
  bool _isRewardedAdReady = false;

  int _count = 0;

  final box = Boxes.getClickCount();

  String imageUrl = "amazing.png";

  @override
  void initState() {
    super.initState();
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
        decoration: const BoxDecoration(color: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Home',
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
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
              SizedBox(
                height: 5.h,
              ),
              FadeAnimation(
                delay: 1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HomeCardWidget(
                      imageURL: 'assets/icons/learn.png',
                      text: 'Learn',
                      color: kPrimaryColor,
                      onTap: () {
                        Navigator.pushNamed(context, '/learn');
                      },
                    ),
                    SizedBox(
                      width: 5.0.w,
                    ),
                    HomeCardWidget(
                      imageURL: 'assets/icons/flash_cards.png',
                      text: 'Flash cards',
                      color: kSecondaryColor,
                      onTap: () {
                        Navigator.pushNamed(context, '/train');
                      },
                    ),
                  ],
                ),
              )
            ]),
          ),
          floatingActionButton:
              BlocBuilder<RemoteConfigBloc, RemoteConfigState>(
            builder: (context, state) {
              //TODO if (state is RemoteConfigLoaded && _isRewardedAdReady) {
              if (state is RemoteConfigLoaded) {
                if (_count <= state.count) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: FloatingActionButton.extended(
                        elevation: 10,
                        onPressed: () {
                          //TODO _rewardedAd.show(onUserEarnedReward: (ad, reward) {
                          //   ScaffoldMessenger.of(context)
                          //       .showSnackBar(snackBar);
                          // });
                          _updateCount();
                          setState(() {
                            _count = _getCount();
                          });
                          _goToQuickLearn();
                        },
                        label: const Text(
                          'Quick Learn',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ));
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

  _goToQuickLearn() {
    
    var state = context.read<IdiomBloc>().state;
    if (state is IdiomLoaded) {
      List<Idiom> idioms = state.idioms;
      var random = Random();
      var randomNumber = random.nextInt(idioms.length);
      Navigator.pushNamed(context, '/learn_detail',
          arguments: idioms[randomNumber]);
    }
  }
}
