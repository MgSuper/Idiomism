import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const maxFailedLoadAttempts = 3;

const kPrimaryColor = Color(0xFF455A64);
const kSecondaryColor = Color(0xFF90A4AE);
const kTertiaryColor = Color(0xFF263238);


const snackBar = SnackBar(
  content: Text('Yay, got a reward !'),
);

TextStyle detailSubtitle = TextStyle(
  fontSize: 12.0.sp,
  color: Colors.white,
);

TextStyle detailMmSubtitle = TextStyle(
  fontSize: 11.0.sp,
  color: Colors.white,
);

TextStyle detailTitle = TextStyle(
  fontSize: 15.0.sp,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
