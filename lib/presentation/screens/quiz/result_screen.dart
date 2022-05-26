import 'package:flutter/material.dart';
import 'package:theidioms/presentation/screens/home/home_screen.dart';

class ResultScreen extends StatefulWidget {
  static const String id = '/result';
  final int score;
  const ResultScreen({Key? key, required this.score}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String? imgPath;
  @override
  void initState() {
    super.initState();
    if (widget.score > 8) {
      imgPath = 'assets/icons/congrats.gif';
    } else if (widget.score < 5) {
      imgPath = 'assets/icons/try_again.gif';
    } else {
      imgPath = 'assets/icons/good_job.gif';
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 2);
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: Image.asset(
                  imgPath!,
                  height: 300.0,
                  width: 500.0,
                )),
                Text(
                  'Your score is ${widget.score} out of 10.',
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            )));
  }
}
