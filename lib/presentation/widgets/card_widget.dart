import 'package:flutter/cupertino.dart';
import 'package:idiomism/util/constants.dart';
import 'package:sizer/sizer.dart';

class CardWidget extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  final String? mmText;
  final String? type;
  final Color? color;

  const CardWidget({Key? key, this.text, this.onTap, this.mmText, this.type, this.color})
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
            color: color,
            borderRadius: BorderRadius.circular(20)
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: (type == 'front')
              ? Text(
                  text!,
                  style: cardTitle,
                  textAlign: TextAlign.center,
                )
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
