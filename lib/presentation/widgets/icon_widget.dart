import 'package:flutter/material.dart';
import 'package:idiomism/presentation/animations/animations.dart';
import 'package:sizer/sizer.dart';

class IconWidget extends StatelessWidget {
  late String title;
  late Widget child;
  late double delayanimation;
  late Color color;
  IconWidget({
    Key? key,
    required this.title,
    required this.child,
    required this.delayanimation,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeAnimation(
              delay: delayanimation,
              child: Container(
                  width: 27.0.w,
                  height: 27.0.w,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: child),
            ),
          ],
        ),
        SizedBox(
          height: 1.0.h,
        ),
        FadeAnimation(
          delay: delayanimation,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 18.0.sp),
          ),
        ),
      ],
    );
  }
}
