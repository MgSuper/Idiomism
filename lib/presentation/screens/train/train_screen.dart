import 'package:flutter/material.dart';
import 'package:idiomism/boxes.dart';
import 'package:idiomism/data/model/flash_card.dart';
import 'package:idiomism/presentation/screens/train_detail/train_detail_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:idiomism/util/constants.dart';

class TrainScreen extends StatefulWidget {
  const TrainScreen({Key? key}) : super(key: key);

  @override
  State<TrainScreen> createState() => _TrainScreenState();
}

class _TrainScreenState extends State<TrainScreen> {
  Iterable<FlashCard>? flashCards;

  final box = Boxes.getFlashCards();

  @override
  void initState() {
    super.initState();
    flashCards = box.values;
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
          body: GridView.count(
            padding: const EdgeInsets.all(10),
            crossAxisCount: 2,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            children: flashCards!
                .map(
                  (item) => GestureDetector(
                      onTap: () => {
                        Navigator.pushNamed(context, TrainDetailScreen.id, arguments: item)
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.teal[200],
                        ),
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                item.phrase,
                                style: TextStyle(
                                    fontSize: 13.0.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                item.meaning,
                                style: TextStyle(fontSize: 12.0.sp),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Icon(Icons.keyboard_voice_outlined),
                                  Icon(Icons.delete_outlined)
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              )
                            ]),
                      )),
                )
                .toList(),
          )),
    );
  }
}
