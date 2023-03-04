
import 'package:coin_follower/screens/registration_screens/login_screen/login_screen.dart';
import 'package:coin_follower/screens/registration_screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const routeName="/AuthScreen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;

  void toggle (){
    setState(() {
      print(isLogin.toString());
      isLogin = !isLogin;
      print(isLogin.toString());
    });
    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return isLogin ? LoginScreen(onClickSignUp: toggle) : SignUpScreen(onClickSignIn: toggle);
  }
}
