import 'package:coin_follower/screens/registration_screens/auth_screen/auth_screen.dart';
import 'package:coin_follower/utils/logger.dart';
import 'package:coin_follower/utils/utils.dart';
import 'package:coin_follower/widgets/auth_image.dart';
import 'package:coin_follower/widgets/custom_text_form_field.dart';
import 'package:coin_follower/widgets/sign_btn.dart';
import 'package:coin_follower/widgets/username_password_column.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignUpBody extends StatefulWidget {
  VoidCallback onClickSignIn;
  SignUpBody({Key? key, required this.onClickSignIn}) : super(key: key);

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final log = getLogs();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future signUp() async {
    print("password is ${passwordController.text.trim().toString()}");
    print(
        "confirm password is ${confirmPasswordController.text.trim().toString()}");
    print(
        "confirm pass result is" + passwordController.text.trim().toString() ==
                confirmPasswordController.text.trim().toString()
            ? true
            : false);
    print("SignUp");
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        value.user!.sendEmailVerification();
        Navigator.of(context).pushNamed(AuthScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      log.i(e);
      // navigatorKey.currentState!.popUntil((route) => route.isFirst);
      print(e);
      Utils.showSnackBar(e.toString());
    }
  }

  canTSignUp() {
    Utils.showSnackBar("You couldn't confirm your password");
  }

  onSignUpClicked() {
    return passwordController.text.trim().toString() ==
            confirmPasswordController.text.trim().toString()
        ? signUp()
        : canTSignUp();
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
        child: Column(
      children: [
        AuthImage(),
        UsernamePasswordColumn(
          emailController: emailController,
          passwordController: passwordController,
          formKey: formKey,
        ),
        Container(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 1.5.h),
          child: CustomTextFormField(
              hintText: 'Confirm Password',
              controller: confirmPasswordController,
              showHideIcon: false),
        ),
        SignBtn(onClick: onSignUpClicked, text: 'Sign Up'),
        buildSignInTextButton()
      ],
    ));
  }

  RichText buildSignInTextButton() {
    return RichText(
        text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 16),
            text: 'Already have account ',
            children: [
          TextSpan(
              recognizer: TapGestureRecognizer()..onTap = widget.onClickSignIn,
              text: 'Log In',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary))
        ]));
  }
}
