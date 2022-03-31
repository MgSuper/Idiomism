import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:idiomism/boxes.dart';
import 'package:idiomism/data/model/flash_card.dart';
import 'package:idiomism/presentation/screens/train_detail/train_detail_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:idiomism/util/constants.dart';

class TrainScreen extends StatefulWidget {
  const TrainScreen({Key? key}) : super(key: key);

  @override
  State<TrainScreen> createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> {
  Iterable<FlashCard>? flashCards;
  late FlutterTts flutterTts;

  final box = Boxes.getFlashCards();

  @override
  void initState() {
    super.initState();
    flashCards = box.values;
    flutterTts = FlutterTts();
  }

  _speak(text) async {
    await flutterTts.setSpeechRate(0.0);
    await flutterTts.setLanguage('en-US');
    await flutterTts.setVoice({"name": "en-us-x-tpf-local", "locale": "en-US"});
    await flutterTts.speak(text);
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
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: (flashCards!.isNotEmpty)
            ? GridView.count(
                padding: const EdgeInsets.all(10),
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                children: flashCards!
                    .map(
                      (item) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 155, 245, 236),
                        ),
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () => {
                                        Navigator.pushNamed(
                                            context, TrainDetailScreen.id,
                                            arguments: item)
                                      },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        item.phrase,
                                        style: TextStyle(
                                            fontSize: 13.0.sp,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                    ],
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.keyboard_voice_outlined),
                                    onPressed: () {
                                      _speak(item.phrase);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outlined),
                                    onPressed: () {
                                      _deleteFlashCard(item);
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              )
                            ]),
                      ),
                    )
                    .toList(),
              )
            : Container(
              transform: Matrix4.translationValues(0, -50.0, 0),
              child: Center(
                child: Text(
                    'Please add a flash card!',
                    style: detailSubtitle,
                    textAlign: TextAlign.center,
                  )
              )
            ),
      ),
    );
  }

  _deleteFlashCard(item) {
    final Map<dynamic, dynamic> cards = box.toMap();
    dynamic desiredKey;
    cards.forEach((key, value) {
      if (value.idiomID == item.idiomID) {
        desiredKey = key;
      }
    });
    box.delete(desiredKey);
    setState(() {
      flashCards = box.values;
    });
  }
}
