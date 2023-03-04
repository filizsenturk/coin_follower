import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatefulWidget {
  final FormFieldValidator<String>? validator;
  final String hintText;
  final TextEditingController controller;
  final bool showHideIcon;

  const CustomTextFormField(
      {Key? key,
      this.validator,
      required this.hintText,
      required this.controller,
      required this.showHideIcon})
      : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscure = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 3.5.w, right: 3.5.w, bottom: 1.5.h),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: Colors.grey,
        textInputAction: TextInputAction.next,
        decoration: buildDecoration(),
        validator: widget.validator,
        obscureText: obscure,
      ),
    );
  }

  InputDecoration buildDecoration() {
    return widget.showHideIcon
        ? InputDecoration(
            labelText: widget.hintText,
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                child: Icon(Icons.remove_red_eye)))
        : InputDecoration(
            labelText: widget.hintText,
          );
  }
}
