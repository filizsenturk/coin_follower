import 'package:coin_follower/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthImage extends StatelessWidget {
  const AuthImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      width: 80.w,
     // height: 15.h,
      child: Image.asset(Strings.icBlockChain),
    );
  }
}
