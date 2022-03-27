import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idiomism/data/model/idiom.dart';
import 'package:idiomism/logic/blocs/idiom/idiom_bloc.dart';
import 'package:idiomism/logic/blocs/remote_config/remote_config_bloc.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = BlocProvider.of<IdiomBloc>(context, listen: true).state;
    if (state is IdiomLoaded) {
      setState(() {
        idioms = state.idioms;
      });
    }
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
              Container(
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
              ),
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
    
  }
}
