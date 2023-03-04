import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/screens/registration_screens/auth_screen/auth_screen.dart';
import 'package:coin_follower/utils/utils.dart';
import 'package:coin_follower/widgets/back_icon.dart';
import 'package:coin_follower/widgets/sign_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = "/ForgotPasswordScreen";
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController controller = TextEditingController();

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: controller.text.trim().toString())
          .then((value) {
        Utils.showSnackBar(Strings.cEmailSend);
        Navigator.of(context).pushNamed(AuthScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.toString());
      // Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            BackIcon(),
            SizedBox(
              height: 50,
            ),
            buildTextForm(),
            buildApproveBtn()
          ],
        ),
      ),
    );
  }

  buildTextForm() {
    return Container(
      padding: EdgeInsets.only(left: 5.w,right: 5.w,bottom: 5.h),
      child: TextFormField(
        decoration: InputDecoration(hintText: Strings.cEmail),
        controller: controller,
      ),
    );
  }

  buildApproveBtn() {
    return SignBtn(onClick: resetPassword, text: Strings.cResetPassword);
  }
}
