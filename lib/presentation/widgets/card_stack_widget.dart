import 'package:flutter/material.dart';
import 'package:idiomism/util/constants.dart';
import 'package:sizer/sizer.dart';

class CardStack extends StatefulWidget {
  final Function? onCardChanged;

  CardStack({this.onCardChanged});
  @override
  _CardStackState createState() => _CardStackState();
}

class _CardStackState extends State<CardStack>
    with SingleTickerProviderStateMixin {
  var cards = [
    TouristCard(
        index: 0,
        imageUrl: "amazing.png",
        text: 'Never stop learning, because life never stop teaching'),
    TouristCard(
        index: 1,
        imageUrl: "good_job.png",
        text: 'Learn one new thing everyday'),
    TouristCard(
        index: 2,
        imageUrl: "doing_great.png",
        text: 'Learning is the eye of the mind'),
    TouristCard(
        index: 3,
        imageUrl: "good.png",
        text: 'The wisest mind has something yet to learn'),
    TouristCard(
        index: 4,
        imageUrl: "slow_n_steady.png",
        text: 'An investment in knowledge pays the best interest'),
    TouristCard(
        index: 5,
        imageUrl: "you_got_this.png",
        text: 'It\'s never late to learn anything'),
  ];
  int? currentIndex;
  AnimationController? controller;
  CurvedAnimation? curvedAnimation;
  Animation<Offset>? _translationAnim;
  Animation<Offset>? _moveAnim;
  Animation<double>? _scaleAnim;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    curvedAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.easeOut);

    _translationAnim =
        Tween(begin: const Offset(0.0, 0.0), end: const Offset(-1000.0, 0.0))
            .animate(controller!)
          ..addListener(() {
            setState(() {});
          });

    _scaleAnim = Tween(begin: 0.965, end: 1.0).animate(curvedAnimation!);
    _moveAnim =
        Tween(begin: const Offset(0.05, 0.00), end: const Offset(0.0, 0.0))
            .animate(curvedAnimation!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        overflow: Overflow.visible,
        children: cards.reversed.map((card) {
          if (cards.indexOf(card) <= 2) {
            return GestureDetector(
              onHorizontalDragEnd: _horizontalDragEnd,
              child: Transform.translate(
                offset: _getFlickTransformOffset(card),
                child: FractionalTranslation(
                  translation: _getStackedCardOffset(card),
                  child: Transform.scale(
                    scale: _getStackedCardScale(card),
                    child: Center(child: card),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        }).toList());
  }

  Offset _getStackedCardOffset(TouristCard card) {
    int diff = card.index! - currentIndex!;
    if (card.index == currentIndex! + 1) {
      return _moveAnim!.value;
    } else if (diff > 0 && diff <= 2) {
      return Offset(0.03 * diff, 0.02);
    } else {
      return const Offset(0.0, 0.0);
    }
  }

  double _getStackedCardScale(TouristCard card) {
    int diff = card.index! - currentIndex!;
    if (card.index == currentIndex) {
      return 1.0;
    } else if (card.index == currentIndex! + 1) {
      return _scaleAnim!.value;
    } else {
      return (1 - (0.035 * diff.abs()));
    }
  }

  Offset _getFlickTransformOffset(TouristCard card) {
    if (card.index == currentIndex) {
      return _translationAnim!.value;
    }
    return const Offset(0.0, 0.0);
  }

  void _horizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity! < 0) {
      // Swiped Right to Left
      controller!.forward().whenComplete(() {
        setState(() {
          controller!.reset();
          TouristCard removedCard = cards.removeAt(0);
          cards.add(removedCard);
          currentIndex = cards[0].index;
          if (widget.onCardChanged != null) {
            widget.onCardChanged!(cards[0].imageUrl);
          }
        });
      });
    }
  }
}

class TouristCard extends StatelessWidget {
  final int? index;
  final String? imageUrl;
  final String? text;
  TouristCard({this.index, this.imageUrl, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.fromLTRB(30, 5, 30, 0),
      child: Stack(children: [
        Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                "assets/icons/$imageUrl",
                fit: BoxFit.fill,
              )),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.only(left: 10, right: 10),
              transform: Matrix4.translationValues(0, -50, 0),
              height: 100,
              child: Center(
                child: Text(
                  text!,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
              ))
        ]),
      ]),
    );
  }
}
