import 'package:coin_follower/screens/registration_screens/auth_screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BackIcon extends StatefulWidget {
   BackIcon({Key? key,}) : super(key: key);

  @override
  State<BackIcon> createState() => _BackIconState();
}

class _BackIconState extends State<BackIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.w,
      padding: EdgeInsets.only(top: 10.h,left: 3.w),
      child: GestureDetector(
        onTap:  (){
          Navigator.of(context).pushNamed(AuthScreen.routeName);
         },
        child: Icon(Icons.arrow_back_ios),
      )
    );
  }
}
