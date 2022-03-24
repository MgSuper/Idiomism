import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const maxFailedLoadAttempts = 3;

const snackBar = SnackBar(
  content: Text('Yay, got a reward !'),
);

TextStyle detailSubtitle = TextStyle(
  fontSize: 14.0.sp,
  fontWeight: FontWeight.bold,
  color: Color(0xFF043875),
);

TextStyle detailTitle = TextStyle(
  fontSize: 20.0.sp,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  decoration: TextDecoration.underline,
);
