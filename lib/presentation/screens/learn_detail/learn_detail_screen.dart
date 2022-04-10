import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:theidioms/boxes.dart';
import 'package:theidioms/data/model/flash_card.dart';
import 'package:theidioms/data/model/idiom.dart';
import 'package:theidioms/util/constants.dart';
import 'package:sizer/sizer.dart';

class LearnDetailScreen extends StatefulWidget {
  final Idiom? passData;
  const LearnDetailScreen({Key? key, this.passData}) : super(key: key);

  @override
  State<LearnDetailScreen> createState() => _LearnDetailScreenState();
}

class _LearnDetailScreenState extends State<LearnDetailScreen> {
  List<Idiom>? idioms;

  final box = Boxes.getFlashCards();

  bool? isAdded;

  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    final list = _checkExistingItem();
    flutterTts = FlutterTts();
    setState(() {
      (list.length > 0) ? isAdded = true : isAdded = false;
    });
  }

  _speak(text) async {
    await flutterTts.setSpeechRate(0.0);
    await flutterTts.setLanguage('en-US');
    await flutterTts.setVoice({'name': 'en-us-x-tpf-local', 'locale': 'en-US'});
    await flutterTts.speak(text);
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
          iconTheme: const IconThemeData(color: kPrimaryColor),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  widget.passData!.phrase,
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                IconButton(
                  icon: const Icon(Icons.keyboard_voice_outlined,
                      color: kSecondaryColor),
                  onPressed: () {
                    _speak(widget.passData!.phrase);
                  },
                )
              ]),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                'Definition',
                style: detailTitle,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Text(
                widget.passData!.meaning,
                style: detailSubtitle,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 1.0.h,
              ),
              Text(
                widget.passData!.mmMeaning,
                style: detailMmSubtitle,
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                'Example',
                style: detailTitle,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Text(
                widget.passData!.sentence,
                style: detailSubtitle,
                textAlign: TextAlign.justify,
              ),
              const Spacer(flex: 1),
              (!isAdded!)
                  ? Container(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: FloatingActionButton.extended(
                          onPressed: () => {_addToFlashCard()},
                          backgroundColor: kSecondaryColor,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Add to flash card',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 5.0.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  _addToFlashCard() {
    final cardItem = FlashCard()
      ..idiomID = widget.passData!.id
      ..phrase = widget.passData!.phrase
      ..meaning = widget.passData!.meaning
      ..mmMeaning = widget.passData!.mmMeaning;
    box.add(cardItem);
    setState(() {
      isAdded = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
  }

  _checkExistingItem() {
    return box.values
        .where((element) => element.idiomID == widget.passData!.id);
  }
}
