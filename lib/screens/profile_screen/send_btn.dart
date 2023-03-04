import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SendBtn extends StatefulWidget {
  VoidCallback onSendClicked;
   SendBtn({Key? key,required this.onSendClicked}) : super(key: key);
  @override
  State<SendBtn> createState() => _SendBtnState();
}

class _SendBtnState extends State<SendBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSendClicked,
      child: Container(
        margin: EdgeInsets.only(top: 2.h,right: 5.w),
        width: 30.w,
        height: 7.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.amberAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ]
        ),
        child: Center(child:
        Text("Send",style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold
        ),)),
      ),
    );
  }
}
