import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:email_validator/email_validator.dart';

class UsernamePasswordColumn extends StatefulWidget {
   TextEditingController emailController;
   TextEditingController passwordController;
   GlobalKey? formKey;
   UsernamePasswordColumn({Key? key,
    required this.passwordController,
    required this.emailController,
      this.formKey
   }) : super(key: key);

  @override
  State<UsernamePasswordColumn> createState() => _UsernamePasswordColumnState();
}

class _UsernamePasswordColumnState extends State<UsernamePasswordColumn> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 10.h,bottom: 1.5.h),
      child:  Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
                hintText: Strings.cEmail,
                controller: widget.emailController,
                showHideIcon: false,
                validator: (email){
                  email != null && !EmailValidator.validate(email) ? 'Enter valid email': 'null';
                },
            ),
            CustomTextFormField(
              showHideIcon: true,
              hintText: Strings.cPassword,
              controller: widget.passwordController,
              validator: (password){
                password != null && password.length<6
                    ? 'Enter min. 6 characters': null;
              },
            ),
          ],
        ),
      ),

    );
  }
}
