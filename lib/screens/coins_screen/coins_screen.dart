import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_follower/constants/api_client.dart';
import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/local_helper/preferecences_helper.dart';
import 'package:coin_follower/models/coin.dart';
import 'package:coin_follower/utils/logger.dart';
import 'package:coin_follower/widgets/coin_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinsScreen extends StatefulWidget {
  List coinList;
  bool isFavouriteScreen;

  CoinsScreen(
      {Key? key,
        required this.coinList,
        required this.isFavouriteScreen

      })
      : super(key: key);

  @override
  State<CoinsScreen> createState() => _CoinsScreenState();
}

class _CoinsScreenState extends State<CoinsScreen> {
  final log = getLogs();
  List myFollowedCoinsList = [];

  getFireBaseData() async {
    final docID = await PreferencesHelper.get(Strings.cEmail);
    final docUser = FirebaseFirestore.instance.collection('users').doc(docID);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      log.i(
          "homepage initialize and my snapshot is ${snapshot.data()!['followed']}");
      setState(() {
        myFollowedCoinsList = snapshot.data()!['followed'];
        print("myFollowedCoin List is $myFollowedCoinsList");
      });
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5),(){return getFireBaseData();});
    getFireBaseData();
    super.initState();
  }

  @override
  void dispose() {
    getFireBaseData();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<Coin>>(
        future: ApiClient().getCoins(Strings.coinsList),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            log.i(" Has snapshot data :  ${snapshot.hasData}");
            return const CircularProgressIndicator();
          } else {
            List<Coin> coins = snapshot.data!;
            if (coins == null) {
              log.i("coin is null");
              return const Center(
                child: Text("Error getting data"),
              );
            } else {
              return ListView.builder(
                  itemCount: coins.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        extentRatio: 0.3,
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              widget.isFavouriteScreen
                                  ? onUnfollowingCoin(coins[index].id)
                                  :
                              onFollowingCoin(coins[index].id);
                            },
                            backgroundColor: Colors.black38,
                            foregroundColor: Colors.white,
                            icon: widget.isFavouriteScreen ? Icons
                                .remove_circle_outlined : Icons.favorite,
                            label: widget.isFavouriteScreen
                                ? "Unfollow"
                                : "Follow",
                          )
                        ],
                      ),
                      child: CoinListItem(
                        coin: coins[index],
                      ),
                    );
                  });
            }
          }
        });


  }

  onUnfollowingCoin(String id) {
    myFollowedCoinsList.remove(id);
    print("myFollowedCoinsList is : " + myFollowedCoinsList.toString());
    setFirebaseData(myFollowedCoinsList);
  //  setState(() {
  //    widget.coinList = myFollowedCoinsList;
  //  });
  }

  void onFollowingCoin(String id) {
    myFollowedCoinsList.add(id);
    setFirebaseData(myFollowedCoinsList);
  }

  void setFirebaseData(List coinList) async {
    final docID = await PreferencesHelper.get(Strings.cEmail);
    final docUser = FirebaseFirestore.instance.collection('users').doc(docID);
    docUser.update({"followed": coinList});
  }
}
