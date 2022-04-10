import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:theidioms/boxes.dart';
import 'package:theidioms/data/model/idiom.dart';
import 'package:theidioms/data/model/interstitial_click_count.dart';
import 'package:theidioms/data/repositories/idiom_repository.dart';
import 'package:theidioms/logic/blocs/idiom/idiom_bloc.dart';
import 'package:theidioms/logic/blocs/remote_config/remote_config_bloc.dart';
import 'package:theidioms/presentation/widgets/search_widget.dart';
import 'package:theidioms/util/ad_helper.dart';
import 'package:theidioms/util/constants.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;

  int _count = 0;

  int _configCount = 0;

  final box = Boxes.getInterstitialCount();

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var state = context.read<RemoteConfigBloc>().state;
    if (state is RemoteConfigLoaded) {
      _configCount = state.count;
    }
    try {
      _count = _getCount();
    } catch (e) {
      DateTime today = _getCurrentDate();
      InterstitialClickCount adsClickCount = InterstitialClickCount()
        ..count = 0
        ..date = today;
      box.add(adsClickCount);
      _count = _getCount();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts >= maxFailedLoadAttempts) {
            _loadInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null && _count <= _configCount) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
          _loadInterstitialAd();
        },
      );
      _interstitialAd!.show();
      _updateCount();
      setState(() {
        _count = _getCount();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final IdiomRepository repository = IdiomRepository();
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Learn',
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            iconTheme: const IconThemeData(color: kPrimaryColor),
          ),
          body: BlocBuilder<IdiomBloc, IdiomState>(builder: (context, state) {
            if (state is IdiomLoading) {
              return const Center(
                child: SpinKitDancingSquare(
                  color: Colors.red,
                  size: 50.0,
                ),
              );
            }
            if (state is IdiomLoaded) {
              List<Idiom> idioms = state.idioms;
              List<String> phrases = getPhrases(idioms);
              return Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TypeAhead(
                        suggestionsCallback: (pattern) => phrases
                            .where((item) => item
                                .toLowerCase()
                                .startsWith(pattern.toLowerCase()))
                            .toList(),
                        onSuggestionSelected: (suggestion) {
                          Idiom idiom = idioms.firstWhere(
                              (element) => element.phrase == suggestion);
                          // _showInterstitialAd();
                          Navigator.pushNamed(
                            context,
                            '/learn_detail',
                            arguments: idiom,
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            color: Colors.grey,
                          ),
                          itemCount: idioms.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                _showInterstitialAd();
                                Navigator.pushNamed(context, '/learn_detail',
                                    arguments: idioms[index]);
                              },
                              title: Text(
                                idioms[index].phrase,
                                style: const TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text('Something went wrong'),
            );
          }),
        ),
      ),
    );
  }

  getPhrases(List<Idiom> idioms) {
    return idioms.map((e) => e.phrase).toList();
  }

  _getCount() {
    return box.getAt(0)?.count ?? 0;
  }

  _updateCount() {
    DateTime today = _getCurrentDate();
    int boxCount = box.getAt(0)?.count ?? 0;
    DateTime boxDate = box.getAt(0)?.date ?? today;

    InterstitialClickCount adsClickCount;
    if (boxDate == today) {
      adsClickCount = InterstitialClickCount()
        ..count = ++boxCount
        ..date = boxDate;
    } else {
      adsClickCount = InterstitialClickCount()
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
