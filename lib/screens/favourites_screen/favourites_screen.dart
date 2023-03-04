
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/local_helper/preferecences_helper.dart';
import 'package:coin_follower/screens/coins_screen/coins_screen.dart';
import 'package:coin_follower/utils/logger.dart';
import 'package:coin_follower/widgets/followed_coins.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<String> myFavourites = [];
  var log = getLogs();
  final firestore = FirebaseFirestore.instance;

  Future<FollowedCoins?> readFollowedCoins()async{
    final docID = await PreferencesHelper.get(Strings.cEmail);
    final docUser = FirebaseFirestore.instance.collection('users').doc(docID);
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return FollowedCoins.fromJson(snapshot.data()!);
    }
  }

  @override
  void dispose() {
    readFollowedCoins();
    // TODO: implement dispose
    super.dispose();
  }

@override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: readFollowedCoins(),
        builder: (context,snapshot){
        log.i("my snapshot is $snapshot");
        if(snapshot.hasError){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasData){
        List followedList =  snapshot.data!.followedCoinsList;
        log.i("followed List is setted as "+snapshot.data!.followedCoinsList.toString());
          return CoinsScreen(coinList: followedList,isFavouriteScreen: true,);
        }else{
          return CircularProgressIndicator();
        }
        });
  }
}


