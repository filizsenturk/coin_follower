import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ProfileTexts extends StatelessWidget {
  final String text;
  const ProfileTexts({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: 30.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            color: Colors.black,
            fontStyle: FontStyle.italic
          ),
          ),
          Text(" ",
            style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                color: Colors.black,
                fontStyle: FontStyle.italic
            ),
          ),

        ],
      ),

    );
  }
}
