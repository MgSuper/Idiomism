import 'package:flutter/material.dart';
import 'package:idiomism/boxes.dart';
import 'package:idiomism/data/model/flash_card.dart';
import 'package:idiomism/data/model/idiom.dart';
import 'package:idiomism/util/constants.dart';
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

  @override
  void initState() {
    super.initState();
    final list = _checkExistingItem();
    setState(() {
      (list.length > 0) ? isAdded = true : isAdded = false;
    });
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: Column(
            children: [
              Text(
                widget.passData!.phrase,
                style: TextStyle(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                'Definition',
                style: detailTitle,
              ),
              SizedBox(
                height: 1.0.h,
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
                height: 1.0.h,
              ),
              Text(
                widget.passData!.sentence,
                style: detailSubtitle,
                textAlign: TextAlign.start,
              ),
              const Spacer(flex: 1),
              (!isAdded!)
                  ? Container(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton.extended(
                        onPressed: () => {_addToFlashCard()},
                        backgroundColor: Colors.white,
                        icon: const Icon(
                          Icons.add,
                          color: kPrimaryColor,
                        ),
                        label: const Text(
                          'Add to flash card',
                          style: TextStyle(color: kPrimaryColor),
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
