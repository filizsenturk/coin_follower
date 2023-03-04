import 'package:coin_follower/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class Utils{
  static showSnackBar(String? text){
    if(text==null) return;
    final snackBar= SnackBar(
      content: Container(
        padding: EdgeInsets.only(bottom: 4.h),
        child: Text(text.split("]").last,
        style: GoogleFonts.poppins(
          fontSize: 16,
         color: Colors.white
         // color: AppColors.signBtnColor
        ),),
      ),
      backgroundColor: Colors.amber,
      duration: Duration(seconds: 3),);
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}