
import 'package:coin_follower/screens/registration_screens/signup_screen/signup_body.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName="/SignUpScreen";
  VoidCallback onClickSignIn;
   SignUpScreen({Key? key,required this.onClickSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SignUpBody(onClickSignIn: onClickSignIn,),
      ),
    );
  }
}
