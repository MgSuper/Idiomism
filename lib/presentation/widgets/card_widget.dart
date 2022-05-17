import 'package:flutter/material.dart';
import 'package:theidioms/util/constants.dart';
import 'package:sizer/sizer.dart';

class CardWidget extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final String? mmText;
  final String? type;
  final Color? color;

  const CardWidget(
      {Key? key, this.text, this.onTap, this.mmText, this.type, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20)),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: (type == 'front')
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        text!,
                        style: cardTitle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.touch_app_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(width: 3.w),
                            const Text(
                              'Tap to see the definition',
                              style: TextStyle(color: Colors.white),
                            ),
                          ])
                    ])
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text!,
                      style: cardTitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Text(
                      mmText!,
                      style: cardMmSubtitle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ));
  }
}

class HomeCardWidget extends StatelessWidget {
  final String? imageURL;
  final String? text;
  final Function()? onTap;
  final Color? color;
  final BorderRadius? borderRadius;
  final double? width;

  const HomeCardWidget(
      {Key? key, this.imageURL, this.text, this.onTap, this.color, this.borderRadius, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Material(
          elevation: 7.0,
          borderRadius: borderRadius,
          child: Container(
            width: width,
            height: 45.w,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: color!,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageURL!,
                  width: 12.w,
                  height: 12.h,
                ),
                Text(
                  text!,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp),
                ),
                SizedBox(
                  height: 3.h,
                )
              ],
            ),
          )),
    );
  }
}
