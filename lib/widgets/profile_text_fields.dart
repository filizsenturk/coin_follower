import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileTextFields extends StatelessWidget {
  final TextEditingController controller;
  const ProfileTextFields({Key? key,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.black38),

      ),
      child: TextFormField(
        controller: controller,
        maxLines: 1,
        maxLength: 40,
      ),
    );
  }
}
