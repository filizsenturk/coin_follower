import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_follower/constants/api_client.dart';
import 'package:coin_follower/constants/strings.dart';
import 'package:coin_follower/local_helper/preferecences_helper.dart';
import 'package:coin_follower/models/coin.dart';
import 'package:coin_follower/screens/home_page_screen/home_page_screen.dart';
import 'package:coin_follower/utils/appcolor.dart';
import 'package:coin_follower/utils/logger.dart';
import 'package:coin_follower/widgets/coin_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CoinsScreen extends StatefulWidget {
  bool isFavouriteScreen;

  CoinsScreen({Key? key, required this.isFavouriteScreen}) : super(key: key);

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
      });
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      return getFireBaseData();
    });
    getFireBaseData();
    super.initState();
  }

  @override
  void dispose() {
    getFireBaseData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Coin>>(
        future: widget.isFavouriteScreen
            ? ApiClient().getCoins(myFollowedCoinsList)
            : ApiClient().getCoins(Strings.coinsList),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            log.i(" Has snapshot data :  ${snapshot.hasData}");
            return const CircularProgressIndicator();
          } else {
            List<Coin> coins = snapshot.data!;
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
                                  : onFollowingCoin(coins[index].id);
                            },
                            backgroundColor: AppColors.followBackgroundColor,
                            foregroundColor: AppColors.backgroundColor,
                            icon: widget.isFavouriteScreen
                                ? Icons.remove_circle_outlined
                                : Icons.favorite,
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
        });
  }

  onUnfollowingCoin(String id) {
    myFollowedCoinsList.remove(id);
    setFirebaseData(myFollowedCoinsList);
    Navigator.of(context).pushNamed(HomePage.routeName);
  }

  void onFollowingCoin(String id) {
    myFollowedCoinsList.add(id);
    List coinIds = [];
    for (int i = 0; i < myFollowedCoinsList.length; i++) {
      return coinIds.add(myFollowedCoinsList[i].id);
    }
    setFirebaseData(coinIds);
  }

  void setFirebaseData(List coinList) async {
    final docID = await PreferencesHelper.get(Strings.cEmail);
    final docUser = FirebaseFirestore.instance.collection('users').doc(docID);
    docUser.update({"followed": coinList});
  }
}
