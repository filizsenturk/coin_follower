import 'dart:convert';

import 'package:coin_follower/models/coin.dart';
import 'package:coin_follower/utils/logger.dart';
import 'package:http/http.dart' as http;

class ApiClient{
  final log = getLogs();
  static const baseUrl = "https://api.coingecko.com/api/v3/";

  Future<Coin> getCoin(String coinId)async{
    Future.delayed(Duration(microseconds: 500));
  final response = await http.get(Uri.parse("${baseUrl}coins/${coinId}?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false"));
  log.i("response value is ${response.body}");
    log.i("response value is ${response.body}");
  log.i("response statuscode is ${response.statusCode}");
  if(response.statusCode==200 ){
   //log.i("this is "+Coin.fromJson(jsonDecode(response.body)).percentChange_1h.toString());
    return Coin.fromJson(jsonDecode(response.body));
  }else{
    throw Exception("Error getting Coin info");
  }
  }

// Future<Coin> getCoinMarketCap(String coinId)async{
//   final response = await http.get(Uri.parse("${baseUrl}coins/${coinId}?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=false"));

// }

  Future<List<Coin>> getCoins(List coinsIds)async{
    List<Coin> coins = [];
    for(String id in coinsIds){
      var coin = await getCoin(id);
      coins.add(coin);
    }
    log.i("coins list is $coins  and length ${coins.length}");
    return coins;
  }
}