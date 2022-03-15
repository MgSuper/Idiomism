import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScreenNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invalid Route'),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Screen Not Found',
              style: TextStyle(fontSize: 30.0.sp),
            ),
          ],
        ),
      ),
    );
  }
}
