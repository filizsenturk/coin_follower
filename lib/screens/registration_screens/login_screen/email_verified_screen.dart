import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/screens/home_page_screen/home_page_screen.dart';
import 'package:coin_follower/screens/registration_screens/auth_screen/auth_screen.dart';
import 'package:coin_follower/widgets/sign_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class EmailVerifiedScreen extends StatefulWidget {
  static const routeName = "/EmailVerifiedScreen";
  const EmailVerifiedScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerifiedScreen> createState() => _EmailVerifiedScreenState();
}

class _EmailVerifiedScreenState extends State<EmailVerifiedScreen> {

  bool isVerified=false;

  onSignInClicked(){
    Navigator.of(context).pushNamed(AuthScreen.routeName);
  }

  @override
  void initState() {
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isVerified ? HomePage(): Container(
        width: 100.w,
        height: 100.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Verify your email",
              style: GoogleFonts.poppins(
                fontSize: 18,
              ),
              ),
              SizedBox(height: 10.h,),
              SignBtn(onClick: onSignInClicked, text: Strings.cSignIn)
            ],
          ),
        ),
      ),
    );
  }
}
