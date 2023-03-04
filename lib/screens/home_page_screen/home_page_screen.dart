
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/local_helper/preferecences_helper.dart';
import 'package:coin_follower/screens/coins_screen/coins_screen.dart';
import 'package:coin_follower/screens/favourites_screen/favourites_screen.dart';
import 'package:coin_follower/screens/profile_screen/edit_profile_screen.dart';
import 'package:coin_follower/screens/profile_screen/profile_screen.dart';
import 'package:coin_follower/screens/registration_screens/auth_screen/auth_screen.dart';
import 'package:coin_follower/utils/appcolor.dart';
import 'package:coin_follower/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  static const routeName="/HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final log = getLogs();
  int _selectedIndex =0;

  onSignOutClicked(){
     _signOut();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamed(AuthScreen.routeName);
  }

  buildSnapshot()async{
    final docID = await PreferencesHelper.get(Strings.cEmail);
    final docUser = FirebaseFirestore.instance.collection('users').doc(docID);
    final snapshot = await docUser.get();
    log.i("snapshot on home screen  is $snapshot");
    if(snapshot.exists){
      log.i("snapshot is exists");
      Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
    }else{
      Navigator.of(context).pushReplacementNamed(EditProfileScreen.routeName);}
  }

  onUserTapped(){
    buildSnapshot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(actions: [
        buildUserInfo(),
        buildSignOut(),
      ],),
      body:
      CoinsScreen(
        isFavouriteScreen: _selectedIndex==0 ? false : true,),
      bottomNavigationBar: BottomNavigationBar(
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.currency_bitcoin,),label:Strings.cCoin),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_outlined,),label:Strings.cFavorites),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:AppColors.selectedItemColor,
        onTap: _onItemTapped,
      ),
    );
  }

  GestureDetector buildUserInfo() {
    return GestureDetector(
      onTap: onUserTapped,
      child: Padding(
        padding:  EdgeInsets.only(right:2.w),
        child: Icon(Icons.person),
      ),
    );
  }

  GestureDetector buildSignOut() {
    return GestureDetector(
      onTap: onSignOutClicked,
      child: Padding(
        padding:  EdgeInsets.only(right:2.w),
        child: Icon(Icons.exit_to_app_rounded),
      ),
    );
  }

   _onItemTapped(int value) {
    setState(() {
      _selectedIndex=value;
    });
  }
}
