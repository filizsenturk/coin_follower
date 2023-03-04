class UsdModel {
  final num price;
  final num volume24h;
  final num percentChange_1h;
  final num percentChange_24h;
  final num percentChange_7d;
  final num percentChange_30d;
  final num percentChange_60d;
  final num percentChange_90d;
  final num marketCap;
  final String lastUpdated;

  UsdModel({
   required this.price,
   required this.volume24h,
   required this.percentChange_1h,
   required this.percentChange_24h,
   required this.percentChange_7d,
   required this.percentChange_30d,
   required this.percentChange_60d,
   required this.percentChange_90d,
   required this.marketCap,
   required this.lastUpdated
      });
  factory UsdModel.fromJson(Map<String,dynamic> json){
    return UsdModel(price: json['price'],
        volume24h: json['volume24h'],
        percentChange_1h:  json['percentChange_1h'],
        percentChange_24h: json['percentChange_24'],
        percentChange_7d:  json['percentChange_7d'],
        percentChange_30d: json['percentChange_30'],
        percentChange_60d: json['percentChange_60'],
        percentChange_90d: json['percentChange_90'],
        marketCap: json['marketCap'],
        lastUpdated: json['lastUpated']);
  }
}
