import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:idiomism/data/model/idiom.dart';
import 'package:idiomism/data/repositories/idiom_repository.dart';
import 'package:idiomism/logic/blocs/idiom/idiom_bloc.dart';
import 'package:idiomism/presentation/widgets/search_widget.dart';
import 'package:idiomism/util/ad_helper.dart';
import 'package:idiomism/util/constants.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key}) : super(key: key);

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempts = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadInterstitialAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
    if (_interstitialAd != null) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final IdiomRepository repository = IdiomRepository();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF17c3ad), Color(0xFFe1f5fc)],
        ),
      ),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Learn'),
          centerTitle: false,
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
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: TypeAhead(
                        suggestionsCallback: (pattern) => phrases
                            .where((item) => item
                                .toLowerCase()
                                .startsWith(pattern.toLowerCase()))
                            .toList(),
                        onSuggestionSelected: (suggestion) {
                          Idiom idiom = idioms.firstWhere(
                              (element) => element.phrase == suggestion);
                          _showInterstitialAd();
                          Navigator.pushNamed(context, '/learn_detail',
                              arguments: idiom);
                        },
                      )),
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: idioms.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          _showInterstitialAd();
                          Navigator.pushNamed(context, '/learn_detail',
                              arguments: idioms[index]);
                        },
                        title: Text(idioms[index].phrase),
                      );
                    },
                  )
                ]));
          }
          return const Center(
            child: Text('Something went wrong'),
          );
        }),
      )),
    );
  }

  getPhrases(List<Idiom> idioms) {
    return idioms.map((e) => e.phrase).toList();
  }
}
