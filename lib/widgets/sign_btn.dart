
import 'package:coin_follower/utils/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SignBtn extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const SignBtn({Key? key,
    required this.onClick,
    required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(top: 2.h,left: 5.w,right: 5.w,bottom: 2.h),
      width: 100.w,
      child:  ElevatedButton.icon(
        onPressed: onClick,
        icon: Icon(Icons.lock_open,color: Colors.amber,),
        style: ElevatedButton.styleFrom(maximumSize: Size.fromHeight(50),backgroundColor: AppColors.signBtnColor),
        label: Padding(
          padding:  EdgeInsets.only(top:1.h,bottom: 1.h),
          child: Text(
            text,
            style:GoogleFonts.poppins( fontSize: 24,color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
