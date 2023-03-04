import 'package:coin_follower/routes.dart';
import 'package:coin_follower/screens/home_page_screen/home_page_screen.dart';
import 'package:coin_follower/screens/registration_screens/auth_screen/auth_screen.dart';
import 'package:coin_follower/utils/appcolor.dart';
import 'package:coin_follower/utils/utils.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Sizer(
        builder: (context, orientation, deviceType) {
     return  MaterialApp(
      scaffoldMessengerKey: messengerKey,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),
      home:
      StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
           if(snapshot.connectionState==ConnectionState.waiting){
             return Center(child: CircularProgressIndicator(),);
           }else if(snapshot.hasError){
             return Center(child:  Text('Something went wrong'),);
           }else if(snapshot.hasData){
            return HomePage();
          }else{
            return AuthScreen();
          }
        },
      ),
    );
    });
  }
}

