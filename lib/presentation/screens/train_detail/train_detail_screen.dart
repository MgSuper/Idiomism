import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:theidioms/data/model/flash_card.dart';
import 'package:theidioms/presentation/widgets/card_widget.dart';
import 'package:theidioms/util/constants.dart';

class TrainDetailScreen extends StatefulWidget {
  static const String id = '/train-detail';
  final FlashCard? passedData;

  const TrainDetailScreen({Key? key, this.passedData}) : super(key: key);

  @override
  State<TrainDetailScreen> createState() => _TrainDetailScreenState();
}

class _TrainDetailScreenState extends State<TrainDetailScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [kPrimaryColor, kSecondaryColor],
          // ),
          color: Colors.white),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: kPrimaryColor),
          ),
          body: FlipCard(
            key: cardKey,
            flipOnTouch: false,
            front: CardWidget(
                text: widget.passedData!.phrase,
                onTap: () => {cardKey.currentState!.toggleCard()},
                type: 'front',
                color: kSecondaryColor),
            back: CardWidget(
                text: widget.passedData!.meaning,
                mmText: widget.passedData!.mmMeaning,
                onTap: () => {cardKey.currentState!.toggleCard()},
                type: 'back',
                color: kPrimaryColor),
          )),
    );
  }
}
