import 'package:flutter/material.dart';
import 'package:idiomism/data/model/idiom.dart';
import 'package:flip_card/flip_card.dart';
import 'package:idiomism/util/constants.dart';
import 'package:sizer/sizer.dart';

class LearnDetailScreen extends StatelessWidget {
  final Idiom? passData;
  const LearnDetailScreen({this.passData});

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
          title: Text('Usage'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '(${passData!.phrase})',
                style: detailTitle,
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                'Meaning',
                style: detailTitle,
              ),
              SizedBox(
                height: 1.0.h,
              ),
              Text(
                passData!.meaning,
                style: detailSubtitle,
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                'Sentence (1)',
                style: detailTitle,
              ),
              SizedBox(
                height: 1.0.h,
              ),
              Text(
                passData!.sentence,
                style: detailSubtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
