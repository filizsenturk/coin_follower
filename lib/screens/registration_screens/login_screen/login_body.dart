
import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/local_helper/local_helper.dart';
import 'package:coin_follower/screens/registration_screens/login_screen/email_verified_screen.dart';
import 'package:coin_follower/screens/registration_screens/login_screen/forgot_password_screen.dart';
import 'package:coin_follower/utils/appcolor.dart';
import 'package:coin_follower/utils/logger.dart';
import 'package:coin_follower/utils/utils.dart';
import 'package:coin_follower/widgets/auth_image.dart';
import 'package:coin_follower/widgets/sign_btn.dart';
import 'package:coin_follower/widgets/username_password_column.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class LoginBody extends StatefulWidget {
  final VoidCallback onClickSignUp;
  const LoginBody({Key? key,required this.onClickSignUp}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
   final log =getLogs();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   buildOnTap(){
     log.i("forgot password started");
     return Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
   }

  Future signIn() async {
    print("Sign In");
    final email= emailController.text.trim();
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: passwordController.text.trim())
          .then((value) {
            LocalHelper.saveLocal(keyToSaveLocal: Strings.cEmail, valueToSaveLocal: email.toString());
            Navigator.of(context).pushNamed(EmailVerifiedScreen.routeName);}
      );
    }on FirebaseAuthException catch(e){
      log.i(e);
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          AuthImage(),
          UsernamePasswordColumn(
            emailController:emailController,
            passwordController:passwordController,
          ),
          SignBtn(onClick: signIn, text: Strings.cSignIn),
          buildForgotPasswordText(),
          buildSignUpTextButton()
        ],
      ),


    );
  }

  RichText buildSignUpTextButton() {
    return RichText(text: TextSpan(
        style: GoogleFonts.poppins(color: AppColors.signBtnColor,fontSize: 16),
        text:   Strings.cNoAccount,
        children: [
          TextSpan(
              recognizer: TapGestureRecognizer()..onTap=widget.onClickSignUp,
              text: Strings.cSignUp,
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary
              )
          )
        ]
    ));
  }


  buildForgotPasswordText() {
    return Padding(
      padding:  EdgeInsets.only(bottom: 1.h),
      child: RichText(
        text: TextSpan(
          recognizer: TapGestureRecognizer()..onTap=buildOnTap,
          text:Strings.cForgotPassword,
          style:GoogleFonts.poppins(
            fontSize: 16,
          decoration: TextDecoration.underline,
            color: AppColors.signBtnColor
          ),


        ),

      ),
    );
  }
}
