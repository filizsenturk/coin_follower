import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ProfileInfoRow extends StatelessWidget {
  final String text;
  final String value;
  VoidCallback onTap;
  ProfileInfoRow(
      {Key? key, required this.text, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.only(top: 10.h, left: 5.w, right: 2.w),
      child: Row(
        children: [
          Container(
              width: 80.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 30.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          text,
                          style: GoogleFonts.montserrat(
                              fontSize: 15.sp,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                        Text(
                          " : ",
                          style: GoogleFonts.montserrat(
                              fontSize: 15.sp,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.montserrat(
                        fontSize: 15.sp, color: Colors.white),
                  )
                ],
              )),
          Container(
            padding: EdgeInsets.only(left: 2.w),
            alignment: Alignment.centerRight,
            child: GestureDetector(onTap: onTap, child: Icon(Icons.edit,color: Colors.white,)),
          )
        ],
      ),
    );
  }
}
