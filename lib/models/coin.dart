

class Coin {
  final String id;
  final String name;
  final String symbol;
  final String imageUrl;
  final double priceVsUsd;
  final double priceChange24h;
  final double percentChange_14d;
  final double percentChange_7d;
  final double percentChange_30d;
  final double percentChange_60d;
  final double percentChange_200d;
 // final double percentChange_90d;

  Coin({
  required this.id,
  required this.name,
  required this.symbol,
  required this.imageUrl,
  required this.priceVsUsd,
 required this.priceChange24h,
 required this.percentChange_14d,
 required this.percentChange_7d,
 required this.percentChange_30d,
 required this.percentChange_60d,
 required this.percentChange_200d,
  });
  factory Coin.fromJson(Map<String,dynamic> json){
    return Coin(
    id: json['id'],
    name: json['name'],
    symbol: json['symbol'],
    imageUrl: json['image']['large'],
    priceVsUsd: json['market_data']['current_price']['usd'].toDouble(),
   priceChange24h: json['market_data']['price_change_percentage_24h'].toDouble(),
   percentChange_14d: json['market_data']['price_change_percentage_14d'].toDouble(),
   percentChange_7d: json['market_data']['price_change_percentage_7d'].toDouble(),
   percentChange_30d: json['market_data']['price_change_percentage_30d'].toDouble(),
   percentChange_60d: json['market_data']['price_change_percentage_60d'].toDouble(),
   percentChange_200d: json['market_data']['price_change_percentage_200d'].toDouble(),
  );}
}
