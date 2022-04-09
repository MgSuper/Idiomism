import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const maxFailedLoadAttempts = 3;

const kPrimaryColor = Color(0xFF42275a);
const kSecondaryColor = Color(0xFF734b6d);
const kTertiaryColor = Color(0xFF263238);

const snackBar = SnackBar(
  content: Text('Yay, got a reward !'),
);

const successSnackBar = SnackBar(
  content: Text('Successfully added to flash card.'),
);

TextStyle detailSubtitle = TextStyle(
  fontSize: 12.0.sp,
  color: kPrimaryColor,
);

TextStyle detailMmSubtitle = TextStyle(
  fontSize: 11.0.sp,
  color: kPrimaryColor,
);

TextStyle detailTitle = TextStyle(
  fontSize: 15.0.sp,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);

TextStyle cardMmSubtitle = TextStyle(
  fontSize: 11.0.sp,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

TextStyle cardTitle = TextStyle(
  fontSize: 15.0.sp,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
