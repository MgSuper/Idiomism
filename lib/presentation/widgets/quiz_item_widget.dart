import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QuizItem extends StatelessWidget {
  const QuizItem({Key? key, required this.text, required this.color})
      : super(key: key);

  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            height: 170.0,
            width: 45.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: color),
            child: Center(
              child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                      fontSize: 15, fontWeight: FontWeight.bold),
                  child: Text(text)),
            )));
  }
}
