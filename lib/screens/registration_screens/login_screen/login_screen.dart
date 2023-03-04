
import 'package:coin_follower/screens/registration_screens/login_screen/login_body.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/LoginScreen';
   VoidCallback onClickSignUp;
   LoginScreen({Key? key,required this.onClickSignUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LoginBody(onClickSignUp: onClickSignUp),
      ),
    );
  }
}
