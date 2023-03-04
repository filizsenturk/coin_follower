
import 'package:coin_follower/models/coin.dart';
import 'package:coin_follower/screens/coins_details_screen/coins_detail_screen.dart';
import 'package:coin_follower/screens/coins_screen/coins_screen.dart';
import 'package:coin_follower/screens/home_page_screen/home_page_screen.dart';
import 'package:coin_follower/screens/profile_screen/edit_profile_screen.dart';
import 'package:coin_follower/screens/profile_screen/profile_screen.dart';
import 'package:coin_follower/screens/registration_screens/auth_screen/auth_screen.dart';
import 'package:coin_follower/screens/registration_screens/login_screen/email_verified_screen.dart';
import 'package:coin_follower/screens/registration_screens/login_screen/forgot_password_screen.dart';
import 'package:flutter/material.dart';



class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    Widget child;
    switch (settings.name) {


      case AuthScreen.routeName:
        {
          child = AuthScreen();
          break;
        }


      case HomePage.routeName:
        {
          child = HomePage();
          break;
        }


      case ForgotPasswordScreen.routeName:
        {
          child = ForgotPasswordScreen();
          break;
        }
      case EmailVerifiedScreen.routeName:
        {
          child = EmailVerifiedScreen();
          break;
        }

      case EditProfileScreen.routeName:
        {
          child = EditProfileScreen();
          break;
        }

      case ProfileScreen.routeName:
        {
          child = ProfileScreen();
          break;
        }

      case CoinsDetailScreen.routeName:
        {
          child = _buildCoinDetailsScreenRoute(settings.arguments as CoinDetailsScreenArguments);
          break;
        }


      default:
        child = Scaffold(
          body: Center(
            child: Text('Create Route for : ${settings.name}'),
          ),
        );
        break;
    }

    return MaterialPageRoute(settings: settings, builder: (_) => applyNewRoute(child));
  }

  static Widget applyNewRoute(Widget child) {
    return Builder(builder: (BuildContext context) {
      final MediaQueryData data = MediaQuery.of(context);
      return MediaQuery(
        data: data.copyWith(textScaleFactor: 1),
        child: child,
      );
    });
  }

  static Widget _buildCoinDetailsScreenRoute(CoinDetailsScreenArguments arguments) {
    Coin coin= arguments.coin;

    return CoinsDetailScreen(
    coin: coin,
    );
  }

}
